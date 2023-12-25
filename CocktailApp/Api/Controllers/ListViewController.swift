//
//  ListViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var drinks: [Drink] = []
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoctailsCategory()
        
        // collectionView
        collectionView.dataSource = self
        
        // navigation
        title = selectedCategory?.strCategory
    }
    
    func fetchCoctailsCategory() {
        guard let selectedCategory = selectedCategory,
              let originalCategory = selectedCategory.strCategory else {
            print("Error: selectedCategory is nil")
            return
        }
        
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
