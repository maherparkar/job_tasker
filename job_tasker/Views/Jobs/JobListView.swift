//
//  JobListView.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import SwiftUI

struct JobListView: View {
    @StateObject var viewModel = JobListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.jobs) { job in
                NavigationLink(destination: JobDetailView(job: job)) {
                    VStack(alignment: .leading) {
                        Text(job.title).font(.headline)
                        Text(job.company).font(.subheadline)
                        Text(job.location).font(.caption)
                    }
                }
            }
            .navigationTitle("Job Listings")
            .navigationBarItems(trailing:
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }
            )
        }
        .onAppear {
            viewModel.loadJobs()
        }
    }
}
