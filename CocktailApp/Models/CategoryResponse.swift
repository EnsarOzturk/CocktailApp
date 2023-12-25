//
//  CategoryResponse.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let drinks: [Category]?
}

// MARK: - Drink
struct Category: Codable {
    let strCategory: String?
}
