//
//  SearchViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit


class SearchViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!
    var cocktails: [Cocktail] = []
    var filteredCocktails: [Cocktail] = []
    var searchController: UISearchController!
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collection
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: SearchListCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        searchUpdate()
        
        // navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search Cocktails"
        
    }
    
    private func searchUpdate() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Cocktails"
        searchController.searchBar.tintColor = UIColor.systemGray
        navigationItem.searchController = searchController
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
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
}

extension SearchViewController: UISearchResultsUpdating {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 24) / 2
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
                filterContentForSearchText(searchText)
                fetchCocktails(for: searchText)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


