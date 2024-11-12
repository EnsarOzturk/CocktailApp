
import Foundation

enum DetailEndpointItem: Endpoint {
    case cocktailDetails(cocktailID: String)
    
    var path: String {
        switch self {
        case .cocktailDetails(let cocktailID):
            return "/lookup.php?i=\(cocktailID)"
        }
    }
}
