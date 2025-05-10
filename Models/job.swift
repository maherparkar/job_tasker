//
//  job.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct Job: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var company: String
    var location: String
    var description: String
    var postedDate: Date
}
