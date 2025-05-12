import SwiftUI

struct SeekerJobListView: View {
    @StateObject private var seekerJobListVM = SeekerJobListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(seekerJobListVM.jobs) { job in
                    NavigationLink(destination: SeekerJobDetailView(job: job)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(job.title)
                                .font(.headline)

                            Text(job.company)
                                .font(.subheadline)

                            Text("Salary: \(job.salary ?? "Not specified")")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("My Jobs")
            .onAppear {
                seekerJobListVM.fetchJobs()  // ✅ Correct usage
            }
        }
    }
}

