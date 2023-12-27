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
    static let identifier = "SearchListCell"
    
    func configure(with cocktail: Cocktail) {
        imageView.setImage(with: cocktail.strDrinkThumb)
        label.text = cocktail.strDrink
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // label
        label.textAlignment = .center
        label.textColor = .white
        
        //view
        view.layer.cornerRadius = 4
        
        //imageView
        imageView.layer.cornerRadius = 8
        
        //cell
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
    }
}
