//
//  SmallCardCell.swift
//  CocktailApp
//
//  Created by Ensar on 27.12.2023.
//

import UIKit
import SDWebImage

final class SmallCardCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    
    struct Constants {
        static let borderWidth: Double = 0.5
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func updateUI() {
        // label
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        // cell
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.cornerRadius
    }
}
