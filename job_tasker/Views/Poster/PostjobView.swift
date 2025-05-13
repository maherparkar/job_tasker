//
//  PostJobView.swift
//  job_tasker
//
//  Created by Maher Parkar on 11/5/2025.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct PostJobView: View {
    @State private var title = ""
    @State private var company = ""
    @State private var location = ""
    @State private var description = ""
    @State private var successMessage = ""
    @State private var errorMessage = ""
    @State private var salary = ""

    @State private var goToMyPosts = false

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            NavigationLink("", destination: PosterJobListView(), isActive: $goToMyPosts)

            VStack(spacing: 20) {
                Text("📢 Post a New Job")
                    .font(.title)
                    .bold()

                Group {
                    HStack {
                        Image(systemName: "briefcase")
                        TextField("Job Title", text: $title)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Image(systemName: "building.2")
                        TextField("Company", text: $company)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Image(systemName: "location")
                        TextField("Location", text: $location)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Image(systemName: "dollarsign.circle")
                        TextField("Salary", text: $salary)
                            .keyboardType(.numberPad)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                ZStack(alignment: .topLeading) {
                    if description.isEmpty {
                        Text("Job Description")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }

                    TextEditor(text: $description)
                        .frame(height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3))
                        )
                        .multilineTextAlignment(.leading)
                }

                if !successMessage.isEmpty {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .font(.subheadline)
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                }

                Button("🚀 Post This Job") {
                    postJob()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Job Posting")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: PosterJobListView()) {
                        Text("📄 My Posts")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { authVM.logout() }) {
                        Text("Logout")
                    }
                }
            }
        }
    }

    func postJob() {
        guard let user = Auth.auth().currentUser else {
            errorMessage = "User not logged in"
            successMessage = ""
            return
        }

        let db = Firestore.firestore()
        let jobData: [String: Any] = [
            "title": title,
            "company": company,
            "location": location,
            "description": description,
            "salary": salary,
            "postedBy": user.uid,
            "postedDate": Timestamp()
        ]

        db.collection("jobs").addDocument(data: jobData) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.successMessage = ""
            } else {
                self.successMessage = "✅ Job posted successfully!"
                self.errorMessage = ""
                self.title = ""
                self.company = ""
                self.location = ""
                self.salary = ""
                self.description = ""

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.successMessage = ""
                    goToMyPosts = true
                }
            }
        }
    }
}

#Preview {
    PostJobView().environmentObject(AuthViewModel())
}

