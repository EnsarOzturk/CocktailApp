//
//  RandomCocktailResponse.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

import Foundation

struct RandomCocktailResponse: Codable {
    let drinks: [RandomCocktail]
}

struct RandomCocktail: Codable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkThumb: String?
}
