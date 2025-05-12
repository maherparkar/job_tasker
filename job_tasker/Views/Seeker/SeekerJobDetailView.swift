import SwiftUI
import Firebase

struct SeekerJobDetailView: View {
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
            }
            .padding()
        }
        .navigationTitle("Job Details")
    }
}

#Preview {
    PosterJobDetailView(job: Job(title: "Test", company: "Test Company", location: "Sydney", description: "Testing Job", postedBy: "1234", postedDate: Date.now))
}
