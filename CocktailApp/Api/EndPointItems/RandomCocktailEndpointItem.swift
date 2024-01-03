//
//  RandomCocktailEndpointItem.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

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

