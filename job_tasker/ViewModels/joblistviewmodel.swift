//
//  joblistviewmodel.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//
import Foundation
import Firebase
import FirebaseFirestore

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []

    func fetchJobs() {
        Firestore.firestore().collection("jobs")
            .order(by: "postedDate", descending: true)
            .getDocuments { snapshot, error in
                if let snapshot = snapshot {
                    self.jobs = snapshot.documents.compactMap { doc in
                        try? doc.data(as: Job.self)
                    }
                }
            }
    }
}
