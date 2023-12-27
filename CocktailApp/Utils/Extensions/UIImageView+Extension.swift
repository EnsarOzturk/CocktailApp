//
//  UIImageView+Extension.swift
//  CocktailApp
//
//  Created by Ensar on 27.12.2023.
//

import Foundation
import SDWebImage

extension UIImageView {
    func setImage(with urlString: String?, placeholderImage: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholderImage
            return
        }

        self.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
}
