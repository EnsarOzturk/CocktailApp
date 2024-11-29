//
//  UIColor+Extension.swift
//  CocktailApp
//
//  Created by Ensar on 18.11.2024.
//

import UIKit

extension UIColor {
    static var customBackgroundColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .black // Koyu modda arka plan siyah olacak
            } else {
                return .white // Açık modda arka plan beyaz olacak
            }
        }
    }
    
    static var customLabelColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .white // Koyu modda metin beyaz olacak
            } else {
                return .black // Açık modda metin siyah olacak
            }
        }
    }
    
    static var customBorderColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .white // Koyu modda gri sınır
            } else {
                return .darkGray // Açık modda daha açık gri sınır
            }
        }
    }
    
    static var customCellBackgroundColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .black // Koyu modda hücre arka planı daha koyu gri
            } else {
                return .white // Açık modda beyaz
            }
        }
    }
    
    static var detailCellBackgroundColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .black // Koyu modda hücre arka planı daha koyu gri
            } else {
                return .white // Açık modda beyaz
            }
        }
    }
    
    static var customTabBarBackgroundColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .black // Koyu modda siyah arka plan
            } else {
                return .white // Açık modda beyaz arka plan
            }
        }
    }
    
    static var customTabBarTintColor: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .white // Koyu modda sarı simge rengi
            } else {
                return .black // Açık modda mavi simge rengi
            }
        }
    }
    
    static var customTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    static var searchTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .white
        }
    }
    
    static var navigationTitleTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    static var customNavigationBarColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
    }
    
    static var customPlaceholderColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.7, alpha: 1.0) : .lightGray
        }
    }
    
    static var randomBackgroundColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
    }
    
    static var randomTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    static var randomBorderColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .lightGray : .black
        }
    }
}
