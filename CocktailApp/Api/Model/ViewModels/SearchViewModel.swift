//
//  SearchViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 2.05.2024.
//

import Foundation

class SearchViewModel {
    let networkManager: NetworkManager
    var cocktails: [Cocktail] = []
    var filteredCocktails: [Cocktail] = []
    var searchText: String = ""
    var viewStyle: ListViewStyle = .small
       
       init(networkManager: NetworkManager) {
           self.networkManager = networkManager
       }
            
    func fetchCocktails(completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = SearchEndpointItem.cocktailName(name: searchText)
        networkManager.request(type: SearchResponse.self, item: endpoint) { [weak self] result in
            switch result {
            case .success(let response):
                let drinks = response.drinks ?? []
                self?.cocktails = drinks
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterCocktailsForSearchText(_ searchText: String) {
        self.searchText = searchText
        filteredCocktails = cocktails.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
    }
    
    func getCocktail(at index: Int) -> Cocktail {
        return isFiltering ? filteredCocktails[index] : cocktails[index]
    }
       
    var numberOfItems: Int {
        return isFiltering ? filteredCocktails.count : cocktails.count
    }
       
    var isFiltering: Bool {
        return !searchText.isEmpty
    }
       
    func toggleViewStyle() {
        viewStyle = (viewStyle == .big) ? .small : .big
    }
}
