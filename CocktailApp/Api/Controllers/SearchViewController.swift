//
//  SearchViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var drinks: [Cocktail] = []
    private let network = NetworkManager()
    private var filteredDrinks: [Cocktail] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
}
