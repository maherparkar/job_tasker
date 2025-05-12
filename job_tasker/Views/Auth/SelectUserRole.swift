//
//  SelectUserRole.swift
//  job_tasker
//
//  Created by Maher Parkar on 11/5/2025.
//

import SwiftUI

struct SelectUserRoleView: View {
    @AppStorage("selectedRole") var selectedRole: String = ""
    @State private var navigateToLogin = false

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Welcome to Job Tasker")
                    .font(.largeTitle)
                    .bold()

                Text("What are you here to do?")
                    .font(.headline)

                Button(action: {
                    selectedRole = "seeker"
                    navigateToLogin = true
                }) {
                    Text("I’m Looking for a Job")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    selectedRole = "poster"
                    navigateToLogin = true
                }) {
                    Text("I Want to Hire Someone")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}
