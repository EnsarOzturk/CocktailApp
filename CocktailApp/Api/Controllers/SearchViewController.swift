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
        
          searchBar()
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: SearchListCell.identifier)
        
    }
    
    private func searchCocktails(query: String) {
        let endpoint = SearchEndpointItem(query: query)
        network.request(type: SearchResponse.self, item: endpoint) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let drinks = response.drinks {
                    self.drinks = drinks
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Movies"
        searchController.definesPresentationContext = false
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        searchCocktails(query: query)
}

//extension SearchViewController: UICollectionViewDelegate {
//
//}

//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isSearching {
//            filteredDrinks.count
//        } else {
//            drinks.count
//        }
//        collectionView.reloadData()
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
}
