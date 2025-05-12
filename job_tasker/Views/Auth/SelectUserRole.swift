import SwiftUI

struct SelectUserRoleView: View {
    @AppStorage("selectedRole") var selectedRole: String = ""
    @State private var navigateToSignup = false
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 40) {
            Text("Welcome to Job Tasker")
                .font(.largeTitle)
                .bold()

            Text("What are you here to do?")
                .font(.headline)

            Button(action: {
                selectedRole = "seeker"
                navigateToSignup = true
            }) {
                Text("I’m Looking for a Job")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                selectedRole = "poster"
                navigateToSignup = true
            }) {
                Text("I Want to Hire Someone")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: SignupView().environmentObject(authVM), isActive: $navigateToSignup) {
                EmptyView()
            }
        }
        .padding()
    }
}

