import SwiftUI

/*
 View for signup screen
 */
struct SignupView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @AppStorage("selectedRole") var selectedRole: String = ""

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()

                TextField("Full Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }

                if selectedRole.isEmpty {
                    Text("Please go back and select a role before signing up.")
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                } else {
                    Button(isLoading ? "Signing up..." : "Sign Up") {
                        isLoading = true
                        authVM.signUp(email: email, password: password, name: name, role: selectedRole) { error in
                            isLoading = false
                            if let error = error {
                                self.errorMessage = error.localizedDescription
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(isLoading)
                }

                NavigationLink("Already have an account? Log In", destination: LoginView())
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

