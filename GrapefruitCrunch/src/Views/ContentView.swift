import SwiftUI

struct ContentView: View {
    @StateObject var pastRecipesManager = PastRecipesManager()
    @State private var selectedTab = "NewRecipe" 
    @Binding var userIsLoggedIn: Bool

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                NewRecipeView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            .tag("NewRecipe")

            NavigationView {
                PastRecipesView()
            }
            .tabItem {
                Image(systemName: "bookmark")
            }
            .tag("PastRecipes")

            NavigationView {
                ProfileView(userIsLoggedIn: $userIsLoggedIn)
            }
            .tabItem {
                Image(systemName: "person.circle")
            }
            .tag("Profile")
        }
        .accentColor(.primaryColor)
        .environmentObject(pastRecipesManager)
    }
}
