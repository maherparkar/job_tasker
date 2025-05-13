
import SwiftUI

/*
 Job List view for Posters. Shows list of all jobs by current poster
 */
struct PosterJobListView: View {
    @StateObject var posterJobListVM = PosterJobListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(posterJobListVM.jobs) { job in
                    NavigationLink(destination: PosterJobDetailView(job: job)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(job.title)
                                .font(.headline)

                            Text(job.company)
                                .font(.subheadline)

                            Text(job.location)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My Posts")
            .refreshable {
                posterJobListVM.fetchJobs()
            }
        }
        .onAppear {
            posterJobListVM.fetchJobs()
        }
    }
}

#Preview {
    PosterJobListView()
}
