
import Foundation

struct SearchResponse: Codable {
    let drinks: [Cocktail]
}

struct Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String?
}
