//
//  DetailEndpointItem.swift
//  CocktailApp
//
//  Created by Ensar on 28.12.2023.
//

import Foundation

enum DetailEndpointItem: Endpoint {
    case lookupCocktailDetails(cocktailID: String)
    
    var path: String {
        switch self {
        case .lookupCocktailDetails(let cocktailID):
            return "/lookup.php?i=\(cocktailID)"
        }
    }
}
