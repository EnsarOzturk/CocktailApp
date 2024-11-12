
import Foundation
import Alamofire

struct RandomCocktailEndpointItem: Endpoint {
   
    var path: String {
        return "/random.php"
    }
    
    var method: HTTPMethod {
          return .get
    }
}

