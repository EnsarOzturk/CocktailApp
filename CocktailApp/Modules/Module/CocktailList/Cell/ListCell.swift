//
//  ListCell.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit
import SDWebImage

class ListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
  
    func configure(drink: Drink) {
        imageView.setImage(with: drink.strDrinkThumb)
        label.text = drink.strDrink
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateUI() // UI'yi tekrar düzenle
        }
    }
    
    private func updateUI() {
        backgroundColor = UIColor.secondarySystemBackground
        // label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
        label.backgroundColor = UIColor.customCellBackgroundColor
        label.font = UIFont(name: "Apple Symbols", size: 15)
        // view
        view.backgroundColor = UIColor.customCellBackgroundColor
        view.layer.cornerRadius = 0.2
        // cell
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.customBorderColor.cgColor
        layer.cornerRadius = 2.0
        layer.backgroundColor = UIColor.systemGray6.cgColor
    }
}

