//
//  SearchEndpointItem.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation

struct SearchEndpointItem: Endpoint {
    let query: String
    
    var path: String {
        return "/search.php"
    }
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "s", value: query)]
    }
}
