//
//  LoginView.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Login").font(.largeTitle).bold()

            TextField("Email", text: $email)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            if !errorMessage.isEmpty {
                Text(errorMessage).foregroundColor(.red)
            }

            Button("Log In") {
                authVM.login(email: email, password: password) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            NavigationLink("Don't have an account? Sign Up", destination: SignupView())
                .padding(.top, 10)
        }
        .padding()
    }
}
