//
//  user.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//

struct AppUser: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var role: String
}
