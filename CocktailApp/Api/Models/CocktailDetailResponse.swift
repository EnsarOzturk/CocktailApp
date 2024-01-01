//
//  DetailResponse.swift
//  CocktailApp
//
//  Created by Ensar on 28.12.2023.
//

import Foundation

struct CocktailDetailResponse: Codable {
    let drinks: [CocktailDetail]
}

struct CocktailDetail: Codable {
    let idDrink: String?
    let strDrink: String?
    let strCategory: String?
    let strIBA: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strInstructionsFR: String?
    let strInstructionsIT: String?
    let strInstructionsZH_HANS: String?
    let strInstructionsZH_HANT: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strImageSource: String?
    let strImageAttribution: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var cocktailContents: [String] {
        return [
            "\(strMeasure1 ?? "")  \(strIngredient1 ?? "")",
            "\(strMeasure2 ?? "")  \(strIngredient2 ?? "")",
            "\(strMeasure3 ?? "")  \(strIngredient3 ?? "")",
            "\(strMeasure4 ?? "")  \(strIngredient4 ?? "")",
            "\(strMeasure5 ?? "")  \(strIngredient5 ?? "")",
            "\(strMeasure6 ?? "")  \(strIngredient6 ?? "")",
            "\(strMeasure7 ?? "")  \(strIngredient7 ?? "")",
            "\(strMeasure8 ?? "")  \(strIngredient8 ?? "")",
            "\(strMeasure9 ?? "")  \(strIngredient9 ?? "")",
            "\(strMeasure10 ?? "")  \(strIngredient10 ?? "")",
            "\(strMeasure11 ?? "")  \(strIngredient11 ?? "")",
            "\(strMeasure12 ?? "")  \(strIngredient12 ?? "")",
            "\(strMeasure12 ?? "")  \(strIngredient13 ?? "")",
            "\(strMeasure13 ?? "")  \(strIngredient14 ?? "")",
            "\(strMeasure14 ?? "")  \(strIngredient15 ?? "")"
        ]
    }
    
    var informations: [String] {
        return [
        strCategory ?? "",
        strIBA ?? "",
        strAlcoholic ?? "",
        strGlass ?? "",
        dateModified ?? ""
        ]
        }
    }



