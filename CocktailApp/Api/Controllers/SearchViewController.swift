//
//  SearchViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit


class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating, UICollectionViewDelegateFlowLayout {
  
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var cocktails: [Cocktail] = []
    var filteredCocktails: [Cocktail] = []
    var searchController: UISearchController!
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: SearchListCell.identifier)
        
        searchController = UISearchController(searchResultsController: nil)
             searchController.searchResultsUpdater = self
             searchController.obscuresBackgroundDuringPresentation = false
             searchController.searchBar.placeholder = "Search Cocktails"

             navigationItem.searchController = searchController
             definesPresentationContext = true
        
    }
    
    func fetchCocktails(for searchQuery: String) {
        let endpoint = SearchEndpointItem.searchByCocktailName(name: searchQuery)
            network.request(type: SearchResponse.self, item: endpoint) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.cocktails = response.drinks
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching cocktails: \(error)")
                }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
                    return filteredCocktails.count
                }
                return cocktails.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.identifier, for: indexPath) as! SearchListCell

                let cocktail: Cocktail
                if isFiltering() {
                    cocktail = filteredCocktails[indexPath.item]
                } else {
                    cocktail = cocktails[indexPath.item]
                }

                cell.configure(with: cocktail)

                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 3
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
                filterContentForSearchText(searchText)
        fetchCocktails(for: searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
          filteredCocktails = cocktails.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
          collectionView.reloadData()
      }
    
    func isFiltering() -> Bool {
            return searchController.isActive && !searchBarIsEmpty()
        }
    func searchBarIsEmpty() -> Bool {
          return searchController.searchBar.text?.isEmpty ?? true
      }
}


