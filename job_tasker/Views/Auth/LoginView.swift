import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var navigateToDashboard = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

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
                }

                Button("Log In") {
                    authVM.login(email: email, password: password) { error in
                        if let error = error {
                            self.errorMessage = error.localizedDescription
                        } else {
                            self.navigateToDashboard = true
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                NavigationLink("Don't have an account? Sign up", destination: SignupView())
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

