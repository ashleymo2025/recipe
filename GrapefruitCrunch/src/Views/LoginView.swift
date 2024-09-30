import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var userIsLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        Spacer().frame(height: geometry.size.height * 0.1)
                        
                        VStack(alignment: .center, spacing: 20) {
                            Text("Welcome to Recipe Generator")
                                .font(.system(size: 23, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                            
                            Text("Please log in to continue")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer().frame(height: geometry.size.height * 0.05)
                        
                        VStack(spacing: 20) {
                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)

                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)

                            Button(action: {
                                login()
                            }) {
                                Text("Login")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.primaryColor)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer().frame(height: geometry.size.height * 0.05)
                        
                        NavigationLink(destination: SignUpView(userIsLoggedIn: $userIsLoggedIn)) {
                            Text("Don't have an account? Sign Up")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.primaryColor)
                        }
                        
                        Spacer()
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                userIsLoggedIn = true
            }
        }
    }
}

