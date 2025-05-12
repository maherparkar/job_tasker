import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var firebaseUser: FirebaseAuth.User?
    @Published var appUser: AppUser?
    private var db = Firestore.firestore()

    init() {
        listenToAuthChanges()
    }

    func listenToAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.firebaseUser = user
            if let user = user {
                self?.fetchUserProfile(uid: user.uid)
            }
        }
    }

    func signUp(email: String, password: String, name: String, role: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self, let user = result?.user, error == nil else {
                completion(error)
                return
            }

            self.firebaseUser = user

            let userData: [String: Any] = [
                "uid": user.uid,
                "name": name,
                "email": email,
                "role": role
            ]

            db.collection("users").document(user.uid).setData(userData) { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.appUser = AppUser(
                            id: user.uid,
                            name: name,
                            email: email,
                            role: role
                        )
                    }
                }
                completion(error)
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let user = result?.user {
                self?.firebaseUser = user
                self?.fetchUserProfile(uid: user.uid)
            }
            completion(error)
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        self.firebaseUser = nil
        self.appUser = nil
    }

    func fetchUserProfile(uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            if let data = snapshot?.data() {
                DispatchQueue.main.async {
                    self?.appUser = AppUser(
                        id: uid,
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        role: data["role"] as? String ?? ""
                    )
                }
            }
        }
    }
}

