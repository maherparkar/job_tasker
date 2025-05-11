//
//  ProfileView.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text("Welcome,")
                .font(.title3)

            if let user = Auth.auth().currentUser {
                Text(user.displayName ?? "User")
                    .font(.title2)
                    .bold()

                Text(user.email ?? "")
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                authVM.logout()
            }) {
                Text("Log Out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .navigationTitle("Profile")
    }
}
