import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var firebaseUser: User?
    @Published var appUser: AppUser?

    private var db = Firestore.firestore()

    init() {
        self.firebaseUser = Auth.auth().currentUser
        if let user = self.firebaseUser {
            fetchUserData(uid: user.uid)
        }

        Auth.auth().addStateDidChangeListener { _, user in
            self.firebaseUser = user
            if let user = user {
                self.fetchUserData(uid: user.uid)
            } else {
                self.appUser = nil
            }
        }
    }

    func signUp(email: String, password: String, name: String, role: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("🔥 Firebase Auth Error: \(error.localizedDescription)")
                completion(error)
                return
            }

            guard let user = result?.user else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user returned"]))
                return
            }

            let userData = [
                "id": user.uid,
                "name": name,
                "email": email,
                "role": role
            ]

            self.db.collection("users").document(user.uid).setData(userData) { error in
                if let error = error {
                    print("❌ Firestore save error: \(error.localizedDescription)")
                    completion(error)
                    return
                }

                self.firebaseUser = user
                self.appUser = AppUser(id: user.uid, name: name, email: email, role: role)
                completion(nil)
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("🔥 Login error: \(error.localizedDescription)")
                completion(error)
                return
            }

            guard let user = result?.user else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user returned"]))
                return
            }

            self.firebaseUser = user
            self.fetchUserData(uid: user.uid)
            completion(nil)
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            self.firebaseUser = nil
            self.appUser = nil
        } catch {
            print("❌ Logout failed: \(error.localizedDescription)")
        }
    }

    private func fetchUserData(uid: String) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.appUser = AppUser(
                    id: uid,
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    role: data["role"] as? String ?? ""
                )
            } else {
                print("❌ Failed to fetch user data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

