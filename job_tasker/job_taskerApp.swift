//
//  job_taskerApp.swift
//  job_tasker
//
//  Created by Maher Parkar on 10/5/2025.
//

import SwiftUI

@main
struct job_taskerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
