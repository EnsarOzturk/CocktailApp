//
//  CategoryCell.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    struct CellConstants {
        static let borderWidth: Double = 0.3
        static let cornerRadius: Double = 4
    }
    
    func configure(category: Category) {
        // label
        label.text = category.strCategory
        // imageView
        let imageName: String
            switch category.strCategory {
            case "Ordinary Drink":
                imageName = "OrdinaryDrink"
            case "Cocktail":
                imageName = "Cocktail"
            case "Shake":
                imageName = "Shake"
            case "Other / Unknown":
                imageName = "OtherUnknown"
            case "Cocoa":
                imageName = "Cocoa"
            case "Shot":
                imageName = "Shot"
            case "Coffee / Tea":
                imageName = "CoffeeTea"
            case "Homemade Liqueur":
                imageName = "HomemadeLiqueur"
            case "Punch / Party Drink":
                imageName = "PunchPartyDrink"
            case "Beer":
                imageName = "Beer"
            case "Soft Drink":
                imageName = "SoftDrink"
            default:
                imageName = "DefaultCategoryImage"
            }
            if let image = UIImage(named: imageName) {
                imageView.image = image
            } else {
                imageView.image = UIImage(named: "DefaultCategoryImage")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    private func updateUI() {
        // label
        label.textColor = .customLabelColor
        // cell
        layer.borderWidth = CellConstants.borderWidth
        layer.borderColor = UIColor.customBorderColor.cgColor
        layer.cornerRadius = CellConstants.cornerRadius
        layer.backgroundColor = UIColor.customCellBackgroundColor.cgColor
    }
}
