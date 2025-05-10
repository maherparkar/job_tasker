//
//  joblistviewmodel.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//
import Foundation

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    private let jobService = JobService()
    
    func loadJobs() {
        jobService.fetchJobs { [weak self] jobs in
            DispatchQueue.main.async {
                self?.jobs = jobs
            }
        }
    }
}

