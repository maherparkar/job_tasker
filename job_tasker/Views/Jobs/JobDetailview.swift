//
//  JobDetailview.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import SwiftUI

struct JobDetailView: View {
    let job: Job
    @State private var showAlert = false
    @State private var isSaved = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(job.title)
                    .font(.title)
                    .bold()

                Text("Company: \(job.company)")
                    .font(.headline)

                Text("Location: \(job.location)")
                    .font(.subheadline)

                Text("Posted: \(job.postedDate, formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.gray)

                Divider()

                Text("Job Description")
                    .font(.headline)
                Text(job.description)
                    .font(.body)

                HStack {
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Apply")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        isSaved.toggle()
                    }) {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Job Details")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Application Sent"), message: Text("You have applied for this job."), dismissButton: .default(Text("OK")))
        }
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
