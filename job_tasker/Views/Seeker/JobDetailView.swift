import SwiftUI
import Firebase

struct JobDetailView: View {
    let job: Job
    @State private var showApplyAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(job.title.isEmpty ? "No Title" : job.title)
                    .font(.title)
                    .bold()

                Text("Company: \(job.company.isEmpty ? "N/A" : job.company)")
                    .font(.headline)

                Text("Location: \(job.location.isEmpty ? "N/A" : job.location)")
                    .font(.subheadline)

                Divider()

                Text("Description")
                    .font(.headline)

                Text(job.description.isEmpty ? "No description provided." : job.description)
                    .font(.body)

                Button("Apply Now") {
                    showApplyAlert = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: $showApplyAlert) {
                    Alert(
                        title: Text("Application Sent"),
                        message: Text("You have successfully applied for this job."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Job Details")
    }
}

