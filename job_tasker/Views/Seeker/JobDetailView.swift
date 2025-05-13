import SwiftUI
import Firebase
import FirebaseAuth

struct JobDetailView: View {
    let job: Job
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showApplyAnimation = false
    @State private var navigateToMyJobs = false
    @State private var showApplyAlert = false

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
        .alert(isPresented: $showApplyAlert) {
            Alert(
                title: Text("Success"),
                message: Text("You have successfully applied for this job."),
                dismissButton: .default(Text("OK"), action: {
                    navigateToMyJobs = true
                })
            )
        }
    }

    private func applyForJob() {
        guard let user = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        let userId = user.uid

        let applicantData: [String: Any] = [
            "userId": userId,
            "name": authVM.appUser?.name ?? "Unknown",
            "email": authVM.appUser?.email ?? "Unknown"
        ]

        // Save to applied_jobs (optional for tracking)
        db.collection("applied_jobs").addDocument(data: [
            "jobId": job.id ?? "",
            "userId": userId,
            "appliedAt": Timestamp()
        ])

        // Append applicant to the job document
        if let jobId = job.id {
            db.collection("jobs").document(jobId).updateData([
                "applicants": FieldValue.arrayUnion([applicantData])
            ]) { error in
                if error == nil {
                    withAnimation {
                        showApplyAnimation = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showApplyAnimation = false
                        showApplyAlert = true  // Triggers alert
                    }
                }
            }
        }
    }
}

