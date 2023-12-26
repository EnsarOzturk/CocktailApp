//
//  ListCell.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class ListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "ListCell"
  
    func configure(drink: Drink) {
        imageView.load(url: drink.strDrinkThumb)
        label.text = drink.strDrink
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // cell
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
