//
//  SearchResponse.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation

struct SearchResponse: Codable {
    let drinks: [Cocktail]
       
       enum CodingKeys: String, CodingKey {
           case drinks = "drinks"
       }
   }

struct Cocktail: Codable {
    let id: String
    let name: String
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumbnail = "strDrinkThumb"
    }
}
