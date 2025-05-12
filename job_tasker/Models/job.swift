//
//  job.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import Foundation
import FirebaseFirestore


struct Applicant: Codable, Identifiable {
    var id: String { userId }
    var userId: String
    var name: String
    var email: String
}

struct Job: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var company: String
    var location: String
    var description: String
    var salary: String?
    var postedBy: String
    var postedDate: Date
    var applicants: [Applicant]? = []
}

