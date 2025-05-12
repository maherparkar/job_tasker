import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class PosterJobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []

    func fetchJobs() {
        Firestore.firestore().collection("jobs")
            .whereField("postedBy", isEqualTo: Auth.auth().currentUser?.uid ?? "")
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
