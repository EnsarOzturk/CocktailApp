//
//  SmallCardCell.swift
//  CocktailApp
//
//  Created by Ensar on 27.12.2023.
//

import UIKit
import SDWebImage

class SmallCardCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    
    static let identifier = "SmallCardCell"
    
    func configure(with cocktail: Cocktail) {
        imageView.setImage(with: cocktail.strDrinkThumb)
        label.text = cocktail.strDrink
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // label
        label.textAlignment = .center
        label.textColor = .white
        // view
        view.layer.cornerRadius = 2
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        // imageView
        imageView.layer.cornerRadius = 4
        
        // cell
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 4
    }
}
