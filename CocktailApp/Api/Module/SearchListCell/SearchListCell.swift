//
//  SearchListCell.swift
//  CocktailApp
//
//  Created by Ensar on 26.12.2023.
//

import UIKit
import SDWebImage

class SearchListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "SearchListCell"
    
    func configure(with cocktail: Cocktail) {
        imageView.setImage(with: cocktail.strDrinkThumb)
        label.text = cocktail.strDrink
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
