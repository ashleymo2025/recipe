import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    @State private var featuredRecipe: Recipe?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to Recipe Generator")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                Text("What would you like to cook today?")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
                if let recipe = featuredRecipe {
                    FeaturedRecipeCard(recipe: recipe)
                } else {
                    ProgressView()
                        .frame(height: 200)
                }
                
                RecentlyViewedSection(foodImageURLs: [
                    URL(string: "https://tiffycooks.com/wp-content/uploads/2021/09/Screen-Shot-2021-09-28-at-11.49.14-PM-500x500.png")!,
                    URL(string: "https://lucyandlentils.co.uk/wp-content/uploads/2023/10/IMG_9088.jpg")!,
                    URL(string: "https://kristineskitchenblog.com/wp-content/uploads/2024/03/salad-recipe-10-2.jpg")!
                ])
                .padding()
                
                TipsAndTricksSection()
            }
            .padding()
        }
        .onAppear(perform: loadFeaturedRecipe)
    }
    
    private func loadFeaturedRecipe() {
        // Simulate loading a featured recipe
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.featuredRecipe = Recipe(title: "Grilled Lemon Herb Chicken", ingredients: ["Chicken", "Lemon", "Herbs"], instructions: "1. Marinate chicken...\n2. Grill until cooked...")
        }
    }
}

struct FeaturedRecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured Recipe")
                .font(.headline)
                .foregroundColor(.primaryColor)
            Text(recipe.title)
                .font(.title2)
                .fontWeight(.bold)
            Text("\(recipe.ingredients.count) ingredients")
                .font(.subheadline)
                .foregroundColor(.gray)
            Button("View Recipe") {
                // Action to view recipe details
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.primaryColor.opacity(0.1))
        .cornerRadius(10)
    }
}

struct RecentlyViewedSection: View {
    // Array of image URLs or food image data
    let foodImageURLs: [URL]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Viewed")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(foodImageURLs.prefix(3), id: \.self) { url in
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 100)
                                    .cornerRadius(10)
                            } else if phase.error != nil {
                                Color.red // Indicates an error
                                    .frame(width: 150, height: 100)
                                    .cornerRadius(10)
                            } else {
                                Color.gray.opacity(0.2) // Placeholder
                                    .frame(width: 150, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct TipsAndTricksSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quick Cooking Advice")
                .font(.headline)
            VStack(alignment: .leading, spacing: 10) {
                TipRow(text: "Use newly purchased ingredients")
                TipRow(text: "Prep ingredients before cooking")
                TipRow(text: "Ensure to use enough salt")
            }
        }
    }
}

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "lightbulb")
                .foregroundColor(.yellow)
            Text(text)
                .font(.subheadline)
        }
    }
}
