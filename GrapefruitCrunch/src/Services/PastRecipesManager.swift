import Foundation
import SwiftUI
import Combine

class PastRecipesManager: ObservableObject {
    @Published var savedRecipes: [Recipe] = [] {
        didSet {
            saveRecipes()
        }
    }

    init() {
        loadRecipes()
    }

    func addRecipe(_ recipe: Recipe) {
        if !savedRecipes.contains(where: { $0.id == recipe.id }) {
            savedRecipes.append(recipe)
        }
    }

    func removeRecipe(_ recipe: Recipe) {
        savedRecipes.removeAll { $0.id == recipe.id }
    }

    private func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(savedRecipes) {
            UserDefaults.standard.set(encoded, forKey: "SavedRecipes")
        }
    }

    private func loadRecipes() {
        if let data = UserDefaults.standard.data(forKey: "SavedRecipes"),
           let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
            savedRecipes = decoded
        }
    }

    func deleteRecipe(at offsets: IndexSet) {
        savedRecipes.remove(atOffsets: offsets)
    }
}
