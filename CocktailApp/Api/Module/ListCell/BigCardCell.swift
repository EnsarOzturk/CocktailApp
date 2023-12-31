//
//  BigCardCell.swift
//  CocktailApp
//
//  Created by Ensar on 27.12.2023.
//

import UIKit
import SDWebImage

class BigCardCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    static let identifier = "BigCardCell"
    
    func configure(drink: Drink) {
        imageView.setImage(with: drink.strDrinkThumb)
        label.text = drink.strDrink
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        // label
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Apple Symbols", size: 20)
        // view
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        // cell
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 2.0
    }
}
