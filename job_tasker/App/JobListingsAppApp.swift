//
//  JobListingsAppApp.swift
//  job_listings
//
//  Created by Maher Parkar on 9/5/2025.
//


@main
struct JobListingsAppApp: App {
    @StateObject var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if authVM.isAuthenticated {
                JobListView()
                    .environmentObject(authVM)
            } else {
                NavigationView {
                    LoginView()
                        .environmentObject(authVM)
                }
            }
        }
    }
}
