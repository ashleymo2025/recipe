import SwiftUI

struct Recipe: Identifiable, Codable {
    var id = UUID()
    var title: String
    var ingredients: [String]
    var instructions: String
}
