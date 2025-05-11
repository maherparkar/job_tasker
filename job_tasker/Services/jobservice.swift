//
//  jobservice.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import Foundation
import FirebaseFirestore

class JobService {
    private let db = Firestore.firestore()
    
    func fetchJobs(completion: @escaping ([Job]) -> Void) {
        db.collection("jobs").order(by: "postedDate", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No jobs found.")
                completion([])
                return
            }
            
            let jobs = documents.compactMap { try? $0.data(as: Job.self) }
            completion(jobs)
        }
    }
}
