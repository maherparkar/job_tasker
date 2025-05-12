import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @AppStorage("selectedRole") private var selectedRole: String = ""

    var body: some View {
        Group {
            if authVM.firebaseUser == nil {
                SelectUserRoleView()
            } else if let role = authVM.appUser?.role {
                switch role {
                case "poster":
                    PostJobView()
                case "seeker":
                    JobListView()
                default:
                    Text("Unknown role: \(role)").foregroundColor(.red)
                }
            } else {
                ProgressView("Loading profile...")
            }
        }
    }
}

#Preview {
    RootView().environmentObject(AuthViewModel())
}
