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
    private var viewStyle: viewStyle = .big
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // collection
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.systemGray6
        collectionView.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: SearchListCell.identifier)
        collectionView.register(UINib(nibName: "SmallCardCell", bundle: nil), forCellWithReuseIdentifier: SmallCardCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        searchUpdate()

        
        // navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.white
        title = "Search Cocktails"
        
        // tabbar
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isFiltering() {
            fetchCocktails(for: "")
        }
    }
    
    private func searchUpdate() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Cocktails"
        searchController.searchBar.tintColor = UIColor.systemGray
        navigationItem.searchController = searchController
    }
    
    func fetchCocktails(for searchQuery: String) {
        let endpoint = SearchEndpointItem.cocktailName(name: searchQuery)
            network.request(type: SearchResponse.self, item: endpoint) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.cocktails = response.drinks
                    self?.saveCocktailsToUserDefaults()
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
    // user defaults
    func loadCocktailsFromUserDefaults() {
          if let data = UserDefaults.standard.data(forKey: "cocktails") {
              let cocktails = try? JSONDecoder().decode([Cocktail].self, from: data)
              self.cocktails = cocktails ?? []
              collectionView.reloadData()
          }
      }
    
    func isFiltering() -> Bool {
            return searchController.isActive && !searchBarIsEmpty()
        }
    func searchBarIsEmpty() -> Bool {
          return searchController.searchBar.text?.isEmpty ?? true
      }
    func saveCocktailsToUserDefaults() {
            let data = try? JSONEncoder().encode(cocktails)
            UserDefaults.standard.set(data, forKey: "cocktails")
        }
    
    
    // viewStyleButton
    @IBAction func viewStyleButtonTapped(_ sender: UIBarButtonItem) {
        viewStyle = viewStyle == .big ? .small : .big
        collectionView.reloadData()
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
        switch viewStyle {
        case .big:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.identifier, for: indexPath) as! SearchListCell
            let cocktail: Cocktail
            if isFiltering() {
            cocktail = filteredCocktails[indexPath.item]
        } else {
            cocktail = cocktails[indexPath.item]
        }
            cell.configure(with: cocktail)
            return cell
        case .small:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardCell.identifier, for: indexPath) as! SmallCardCell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDrink = cocktails[indexPath.row]
        showDetailViewController(with: selectedDrink.idDrink)
    }
   
    func showDetailViewController(with drinkId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            detailVC.cocktailId = drinkId
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
    

extension SearchViewController: UISearchResultsUpdating {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewStyle {
        case .big:
            let width = (UIScreen.main.bounds.width - 24) / 2
            let height = width / 2 * 3
            return CGSize(width: width, height: height)
        case .small:
            let width = (UIScreen.main.bounds.width - 32) / 3
            let height = width / 2 * 3
            return CGSize(width: width, height: height)
        }
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

enum listViewStyle {
    case big
    case small
}


