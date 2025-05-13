//
//  JobListView.swift
//  job_tasker
//
//  Created by Maher Parkar on 11/5/2025.
//

import SwiftUI
import Firebase

/*
 Job List view for Seekers who have not applied yet
 */
struct JobListView: View {
    @StateObject var viewModel = JobListViewModel()
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search jobs...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.filteredJobs) { job in
                        NavigationLink(destination: JobDetailView(job: job)) {
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
            }
            .navigationTitle("Available Jobs")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: {
                        SeekerJobListView()
                    }, label: {
                        Text("My Jobs")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        authVM.logout()
                    }, label: {
                        Text("Logout")
                    })
                }
            }
            .refreshable {
                viewModel.fetchJobs()
            }
        }
        .onAppear {
            viewModel.fetchJobs()
        }
    }
}

#Preview {
    JobListView()
}
