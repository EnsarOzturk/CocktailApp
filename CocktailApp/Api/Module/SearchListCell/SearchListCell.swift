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
    @IBOutlet weak var view: UIView!
    
    struct Constants {
        static let borderWidth: Double = 0.3
        static let cornerRadius: Double = 2.0
    }
    
    func configure(with cocktail: Cocktail) {
        imageView.setImage(with: cocktail.strDrinkThumb)
        label.text = cocktail.strDrink
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    private func updateUI() {
        // label
        label.textAlignment = .center
        label.textColor = .white
        // cell
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.cornerRadius
    }
}
