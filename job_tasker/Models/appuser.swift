//
//  user.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var savedJobs: [String] // Job IDs
}
