//
//  UIImage+Extension.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String?) {
        guard let urlString = url,let imageURL = URL(string: urlString) else { return }
//        DispatchQueue.global(qos: .background).async { [weak self] in
//                  if let data = try? Data(contentsOf: imageURL) {
//                      // Görüntüyü ana ekranda gösterme
//                      if let image = UIImage(data: data) {
//                          DispatchQueue.main.async {
//                              // Eğer hücre tekrar kullanılmamışsa, görseli atama
//                              if let strongSelf = self {
//                                  strongSelf.image = image
//                              }
//                          }
//                      }
//                  }
//              }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
