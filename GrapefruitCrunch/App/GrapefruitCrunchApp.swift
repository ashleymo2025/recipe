import SwiftUI
import Firebase
import FirebaseAuth

@main
struct GrapefruitCrunchApp: App {
    @State private var userIsLoggedIn = false

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if userIsLoggedIn {
                ContentView(userIsLoggedIn: $userIsLoggedIn)
                    .environmentObject(PastRecipesManager())
            } else {
                LoginView(userIsLoggedIn: $userIsLoggedIn)
                    .onAppear {
                        checkUserAuthStatus()
                    }
            }
        }
    }

    func checkUserAuthStatus() {
        if Auth.auth().currentUser != nil {
            userIsLoggedIn = true
        }
    }
}
