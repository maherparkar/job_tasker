//
//  MyJobsList.swift
//  job_tasker
//
//  Created by Maher Parkar on 13/5/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

/*
 Job List view for all jobs current seeker has applied to
 */
struct MyJobsListView: View {
    @State private var jobs: [Job] = []

    var body: some View {
        List(jobs) { job in
            VStack(alignment: .leading) {
                Text(job.title).font(.headline)
                Text(job.company).font(.subheadline)
                Text(job.location).font(.caption).foregroundColor(.gray)
            }
        }
        .navigationTitle("My Applied Jobs")
        .onAppear(perform: fetchAppliedJobs)
    }

    func fetchAppliedJobs() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()

        db.collection("applied_jobs").whereField("userId", isEqualTo: user.uid).getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else { return }

            let jobIds = docs.compactMap { $0.data()["jobId"] as? String }

            if !jobIds.isEmpty {
                db.collection("jobs").whereField(FieldPath.documentID(), in: jobIds).getDocuments { snapshot, error in
                    if let docs = snapshot?.documents {
                        self.jobs = docs.compactMap { try? $0.data(as: Job.self) }
                    }
                }
            }
        }
    }
}
