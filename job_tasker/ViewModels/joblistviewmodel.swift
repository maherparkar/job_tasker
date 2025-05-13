import Foundation
import Firebase
import FirebaseFirestore

/*
 Job List View Model fetches all currently available jobs in the system
 */

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var searchText: String = ""
    
    var filteredJobs: [Job] {
        if searchText.isEmpty {
            return jobs
        }
        return jobs.filter { job in
            job.title.localizedCaseInsensitiveContains(searchText) ||
            job.company.localizedCaseInsensitiveContains(searchText) ||
            job.location.localizedCaseInsensitiveContains(searchText)
        }
    }

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
