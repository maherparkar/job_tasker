import SwiftUI
import Firebase

@main
struct JobTaskerApp: App {
    @StateObject private var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
            }
            .environmentObject(authVM)  // Inject AuthViewModel here for all descendants
        }
    }
}

