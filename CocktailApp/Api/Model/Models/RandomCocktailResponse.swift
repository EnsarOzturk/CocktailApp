
import Foundation

struct RandomCocktailResponse: Codable {
    let drinks: [RandomCocktail]
}

struct RandomCocktail: Codable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkThumb: String?
}
