//
//  Endpoint.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation
import Alamofire

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    func handle(error: Error)
}

extension Endpoint {
    func handle(error: Error) {
        print("Endpoint Error: \(error)")
    }
}

extension Endpoint {
    var baseUrl: String {
        return "https://www.thecocktaildb.com/api/json/v1/1"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var url: String {
        return baseUrl + path
    }
}
