
import Foundation

struct ListResponse: Codable {
    let drinks: [Drink]?
}

struct Drink: Codable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkThumb: String?
}
