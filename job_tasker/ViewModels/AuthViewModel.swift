//
//  AuthViewModel.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated: Bool = false
    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        listenToAuthChanges()
    }

    func listenToAuthChanges() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
        }
    }

    func signUp(email: String, password: String, name: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges(completion: { _ in
                completion(nil)
            })
        }
    }

    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        self.isAuthenticated = false
    }
}
