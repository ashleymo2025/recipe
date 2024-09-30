import Foundation
import SwiftUI

struct NewRecipeView: View {
    @State private var ingredients: [String] = []
    @State private var currentIngredient = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Let's find a recipe for you!")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.top)

            Text("Enter ingredients you already have")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            HStack {
                TextField("Type your ingredients", text: $currentIngredient)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: addIngredient) {
                    Text("Add")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal)

            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                .onDelete(perform: deleteIngredient)
            }
            .frame(height: 200)

            NavigationLink(destination: RecipeGeneratorView(ingredients: ingredients)) {
                Text("Generate Recipe")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal)
            .disabled(ingredients.isEmpty)
        }
        .padding(.top)
    }

    private func addIngredient() {
        guard !currentIngredient.isEmpty else { return }
        ingredients.append(currentIngredient)
        currentIngredient = ""
    }

    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}
