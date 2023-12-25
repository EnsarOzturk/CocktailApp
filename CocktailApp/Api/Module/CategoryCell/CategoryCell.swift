//
//  CategoryCell.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "CategoryCell"
    
    func configure(category: Category) {
        label.text = category.strCategory
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // label
        label.textAlignment = .center
        label.font = UIFont(name: "Copperplate", size: 12)
        
        // cell
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
    }
}
