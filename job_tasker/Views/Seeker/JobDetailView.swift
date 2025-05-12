import SwiftUI
import Firebase
import FirebaseAuth

struct JobDetailView: View {
    let job: Job
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showApplyAnimation = false
    @State private var navigateToMyJobs = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(job.title.isEmpty ? "No Title" : job.title)
                    .font(.title)
                    .bold()

                Text("Company: \(job.company.isEmpty ? "N/A" : job.company)")
                    .font(.headline)

                Text("Salary: \(job.salary?.isEmpty == false ? job.salary! : "Not specified")")
                    .font(.subheadline)
                    .foregroundColor(.blue)

                Text("Location: \(job.location.isEmpty ? "N/A" : job.location)")
                    .font(.subheadline)

                Divider()

                Text("Description")
                    .font(.headline)
                Text(job.description.isEmpty ? "No description provided." : job.description)
                    .font(.body)

                Button("Apply Now") {
                    applyForJob()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(showApplyAnimation ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: showApplyAnimation)

                // Navigation trigger after animation
                NavigationLink(destination: MyJobsListView(), isActive: $navigateToMyJobs) {
                    EmptyView()
                }
            }
            .padding()
        }
        .navigationTitle("Job Details")
    }

    private func applyForJob() {
        guard let user = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        let appliedData: [String: Any] = [
            "jobId": job.id ?? UUID().uuidString,
            "userId": user.uid,
            "appliedAt": Timestamp()
        ]

        db.collection("applied_jobs").addDocument(data: appliedData) { error in
            if error == nil {
                withAnimation {
                    showApplyAnimation = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showApplyAnimation = false
                    navigateToMyJobs = true
                }
            }
        }
    }
}

