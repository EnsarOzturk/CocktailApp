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
    
    struct Constants {
        static let labelFont: String = "Apple Symbols"
        static let labelSize: Double = 20
        static let borderWidth: Double = 0.5
        static let cornerRadius: Double = 2.0
        static let viewRadius: Double = 4
        static let numberOfLines: Int = 0
    }
    
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
        label.backgroundColor = UIColor.customCellBackgroundColor
        label.textAlignment = .center
        label.numberOfLines = Constants.numberOfLines
        label.textColor = .label
        label.font = UIFont(name: Constants.labelFont, size: Constants.labelSize)
        // view
        view.backgroundColor = UIColor.customCellBackgroundColor
        view.layer.cornerRadius = Constants.viewRadius
        // cell
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.customBorderColor.cgColor
        layer.cornerRadius = Constants.cornerRadius
    }
}
