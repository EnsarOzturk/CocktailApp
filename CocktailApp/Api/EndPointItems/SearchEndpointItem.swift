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

    var path: String {
        switch self {
        case .searchByCocktailName(let name):
            return "/search.php?s=\(name)"
        case .listCocktailsByFirstLetter(let letter):
            return "/search.php?f=\(letter)"
        }
    }
}

