//
//  SearchResponse.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation

struct SearchResponse: Codable {
    let drinks: [Cocktail]
   }

struct Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String?
    
}
