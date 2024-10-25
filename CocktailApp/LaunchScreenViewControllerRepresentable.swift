//
//  LaunchScreenViewControllerRepresentable.swift
//  CocktailApp
//
//  Created by Ensar on 25.10.2024.
//

import SwiftUI
import UIKit

struct LaunchScreenViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LaunchScreenViewController {
        return LaunchScreenViewController()
    }
    
    func updateUIViewController(_ uiViewController: LaunchScreenViewController, context: Context) {
        // Güncellemeleri burada yapabilirsiniz, gerekirse SwiftUI ile UIViewController arasında veri paylaşabilirsiniz.
    }
}
