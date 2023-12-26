//
//  SearchListCell.swift
//  CocktailApp
//
//  Created by Ensar on 26.12.2023.
//

import UIKit

class SearchListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "SearchListCell"
    
    func configure(drink: Drink) {
        imageView.load(url: drink.strDrinkThumb)
        label.text = drink.strDrink
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
