//
//  JobDetailView.swift
//  job_tasker
//
//  Created by Maher Parkar on 11/5/2025.
//

import SwiftUI
import Firebase


struct JobDetailView: View {
    let job: Job
    @State private var showApplyAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(job.title)
                    .font(.title)
                    .bold()

                Text("Company: \(job.company)")
                    .font(.headline)

                Text("Location: \(job.location)")
                    .font(.subheadline)

                Divider()

                Text("Description")
                    .font(.headline)
                Text(job.description)
                    .font(.body)

                Button("Apply Now") {
                    showApplyAlert = true
                    // Add application logic here later
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                .alert(isPresented: $showApplyAlert) {
                    Alert(
                        title: Text("Application Sent"),
                        message: Text("You have successfully applied for this job."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Job Details")
    }
}
