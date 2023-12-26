//
//  SearchListCell.swift
//  CocktailApp
//
//  Created by Ensar on 26.12.2023.
//

import UIKit
import Alamofire

class SearchListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "SearchListCell"
    
    func configure(cocktail: Search) {
        imageView.load(url: cocktail.strDrinkThumb)
        label.text = cocktail.strDrink
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
