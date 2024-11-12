
import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let drinks: [Category]?
}

// MARK: - Drink
struct Category: Codable {
    let strCategory: String?
}
