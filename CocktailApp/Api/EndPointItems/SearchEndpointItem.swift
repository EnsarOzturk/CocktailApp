
import Foundation

enum SearchEndpointItem: Endpoint {
    
    case cocktailName(name: String)
    case cocktailFirstLetter(letter: String)
    case cocktailCategory(category: String)
    case popularCocktails

    var path: String {
        switch self {
        case .cocktailName(let name):
            return "/search.php?s=\(name)"
        case .cocktailFirstLetter(let letter):
            return "/search.php?f=\(letter)"
        case .cocktailCategory(let category):
            return "/filter.php?c=\(category)"
        case .popularCocktails:
            return "/filter.php?c=Cocktail"
        }
    }
}


