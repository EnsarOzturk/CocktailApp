//
//  ListResponse.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation

struct DesiredDrinkResponse: Codable {
    let drinks: [Drink]?
}

struct Drink: Codable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkThumb: String?
}
