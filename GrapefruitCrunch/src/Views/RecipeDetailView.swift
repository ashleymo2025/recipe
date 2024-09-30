import SwiftUI


struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryColor)

                Text(recipe.instructions)
            }
            .padding()
        }
        .navigationTitle(recipe.title)
    }
}
