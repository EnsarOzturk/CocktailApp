//
//  SearchEndpointItem.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation
import Alamofire

enum SearchEndpointItem: Endpoint {
    case searchByName(query: String)
    
    var path: String {
        switch self {
        case .searchByName(let query):
            return "/search.php?s=\(query)"
        }
    }
}

extension SearchEndpointItem {
    func handle(error: Error) {
        print("Search Endpoint Error: \(error)")
    }
}
