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
    
    private func updateUI() {
        // label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Apple Symbols", size: 15)
        // view
        view.layer.cornerRadius = 0.2
        // cell
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 2.0
        layer.backgroundColor = UIColor.systemGray6.cgColor
    }
}

