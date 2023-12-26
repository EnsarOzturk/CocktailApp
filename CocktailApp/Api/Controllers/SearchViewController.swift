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

//        collectionView.delegate = self
//        collectionView.dataSource = self
        
    }
}

//extension SearchViewController: UICollectionViewDelegate {
//
//}
//
//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
//
//extension SearchViewController: UICollectionViewDelegateFlowLayout {
//
//}
