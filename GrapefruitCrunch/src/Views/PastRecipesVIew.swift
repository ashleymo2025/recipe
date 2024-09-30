import SwiftUI

struct PastRecipesView: View {
    @EnvironmentObject var pastRecipesManager: PastRecipesManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Saved Recipes")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.top)

            NavigationLink(destination: NewRecipeView()) {
                Text("Find New Recipe")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal)

            if pastRecipesManager.savedRecipes.isEmpty {
                Text("You haven't saved any recipes yet")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            } else {
                Text("Swipe left on a recipe to delete")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 10)

                List {
                    ForEach(pastRecipesManager.savedRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(recipe.title)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    .foregroundColor(.black)
                                Text("\(recipe.ingredients.count) ingredients")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onDelete(perform: deleteRecipe)
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding(.top)
        .navigationBarItems(trailing: EditButton())
    }

    private func deleteRecipe(at offsets: IndexSet) {
        pastRecipesManager.savedRecipes.remove(atOffsets: offsets)
    }
}
