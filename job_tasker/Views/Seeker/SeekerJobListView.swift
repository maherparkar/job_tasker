

import SwiftUI

struct SeekerJobListView: View {
    @StateObject var seekerJobListVM = SeekerJobListViewModel()

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

                            Text(job.location)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My Jobs")
            .refreshable {
                seekerJobListVM.fetchJobs()
            }
        }
        .onAppear {
            seekerJobListVM.fetchJobs()
        }
    }
}

#Preview {
    SeekerJobListView()
}
