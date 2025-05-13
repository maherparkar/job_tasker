import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

/*
 Seeker Job List View Model fetches all jobs in the system that a Seeker has applied to
 */


class SeekerJobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []

    func fetchJobs() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("applied_jobs")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }

                let jobIds = documents.compactMap { $0["jobId"] as? String }

                // Only proceed if jobIds array is not empty
                guard !jobIds.isEmpty else {
                    DispatchQueue.main.async {
                        self.jobs = []
                    }
                    return
                }

                Firestore.firestore().collection("jobs")
                    .whereField(FieldPath.documentID(), in: jobIds)
                    .getDocuments { jobSnapshot, error in
                        guard let jobDocs = jobSnapshot?.documents else { return }

                        DispatchQueue.main.async {
                            self.jobs = jobDocs.compactMap { doc in
                                try? doc.data(as: Job.self)
                            }
                        }
                    }
            }
    }
}

