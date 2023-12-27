//
//  SearchEndpointItem.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation

enum SearchEndpointItem: Endpoint {
    
    case searchByCocktailName(name: String)
    case listCocktailsByFirstLetter(letter: String)
    case searchCocktailsByCategory(category: String)

    var path: String {
        switch self {
        case .searchByCocktailName(let name):
            return "/search.php?s=\(name)"
        case .listCocktailsByFirstLetter(let letter):
            return "/search.php?f=\(letter)"
        case .searchCocktailsByCategory(let category):
            return "/filter.php?c=\(category)"
        }
    }
}


