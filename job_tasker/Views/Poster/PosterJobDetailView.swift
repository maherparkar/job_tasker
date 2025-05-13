import SwiftUI
import Firebase

struct PosterJobDetailView: View {
    let job: Job
    @State private var showApplyAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Job Title
                Text(job.title.isEmpty ? "No Title" : job.title)
                    .font(.title)
                    .bold()
                
                // Company
                Text("Company: \(job.company.isEmpty ? "N/A" : job.company)")
                    .font(.headline)

                // Location
                Text("Location: \(job.location.isEmpty ? "N/A" : job.location)")
                    .font(.subheadline)
                
                // Salary
                Text("Salary: \(job.salary?.isEmpty == false ? job.salary! : "Not specified")")
                    .font(.subheadline)
                    .foregroundColor(.blue)

                Divider()

                // Description
                Text("Description")
                    .font(.headline)

                Text(job.description.isEmpty ? "No description provided." : job.description)
                    .font(.body)

                Divider()
                
                // Applicants
                Text("Applicants")
                    .fontWeight(.bold)
                    .padding(4)
                    .background(Color.green)
                    .cornerRadius(10)

                if let applicants = job.applicants, !applicants.isEmpty {
                    ForEach(applicants) { applicant in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name: \(applicant.name)")
                            Text("Email: \(applicant.email)")
                        }
                        .padding(.vertical, 4)
                    }
                } else {
                    Text("No applicant details found.")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationTitle("Job Details")
    }
}

#Preview {
    PosterJobDetailView(job: Job(
        id: "test-id",
        title: "iOS Developer",
        company: "TechNova",
        location: "Sydney",
        description: "Looking for an experienced SwiftUI developer.",
        salary: "$120,000",
        postedBy: "poster-user-id",
        postedDate: Date(),
        applicants: [
            Applicant(userId: "user123", name: "John Doe", email: "john@example.com"),
            Applicant(userId: "user456", name: "Jane Smith", email: "jane@example.com")
        ]
    ))
}

