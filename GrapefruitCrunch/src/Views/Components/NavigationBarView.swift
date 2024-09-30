import SwiftUI

struct NavigationBarView: View {
    @Binding var currentView: String

    var body: some View {
        HStack {
            Spacer()

            Button(action: { currentView = "NewRecipe" }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(currentView == "NewRecipe" ? .primaryColor : .gray)
            }
            Spacer()

            Button(action: { currentView = "PastRecipes" }) {
                Image(systemName: "bookmark")
                    .foregroundColor(currentView == "PastRecipes" ? .primaryColor : .gray)
            }
            Spacer()

            Image(systemName: "person.circle")
                .foregroundColor(.gray)
        }
        .padding()
    }
}
