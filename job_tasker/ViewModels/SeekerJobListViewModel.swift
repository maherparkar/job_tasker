import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class SeekerJobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []

    func fetchJobs() {
        Firestore.firestore().collection("jobs")
            .whereField("postedBy", isEqualTo: Auth.auth().currentUser?.uid ?? "") // change this to where `applicant` is equal to current user id
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
