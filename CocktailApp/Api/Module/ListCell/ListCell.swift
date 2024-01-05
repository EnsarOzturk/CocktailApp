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
    static let identifier = "ListCell"
  
    func configure(drink: Drink) {
        imageView.setImage(with: drink.strDrinkThumb)
        label.text = drink.strDrink
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // label
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Apple Symbols", size: 15)
        // view
        view.layer.cornerRadius = 0.2
        // cell
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 4
        layer.backgroundColor = UIColor.systemGray6.cgColor
    }
}

