//
//  SearchViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 2.05.2024.
//

import Foundation
import Alamofire

protocol SearchViewModelProtocol: AnyObject {
    var searchText: String { get set }
    var viewStyle: ListViewStyle { get set }
    var numberOfItems: Int { get }
    func fetchCocktails(searchQuery: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func filterCocktailsForSearchText(_ searchText: String)
    func getCocktail(at index: Int) -> Cocktail
    func toggleViewStyle()
}

final class SearchViewModel: SearchViewModelProtocol {
    private let networkManager: NetworkManager
    private var cocktails: [Cocktail] = []
    private var filteredCocktails: [Cocktail] = []
    var searchText: String = ""
    var viewStyle: ListViewStyle = .small
       
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    var numberOfItems: Int {
        return isFiltering ? filteredCocktails.count : cocktails.count
    }
    
    var isFiltering: Bool {
        return !searchText.isEmpty
    }
    
    func fetchCocktails(searchQuery: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = searchQuery.isEmpty ? SearchEndpointItem.popularCocktails : SearchEndpointItem.cocktailName(name: searchQuery)
        networkManager.request(type: SearchResponse.self, item: endpoint) { [weak self] result in
            switch result {
            case .success(let response):
                let drinks = response.drinks
                self?.cocktails = drinks
                completion(.success(()))
            case .failure(let error):
                // AFError kullanarak NetworkError'a dönüştürme
                if let afError = error as? AFError {
                    switch afError {
                    case .invalidURL:
                        completion(.failure(.invalidParameters))
                    case .responseSerializationFailed:
                        completion(.failure(.requestFailed))
                    default:
                        completion(.failure(.requestFailed))
                    }
                } else {
                    completion(.failure(.requestFailed)) // Genel hata
                }
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
       
    func toggleViewStyle() {
        viewStyle = (viewStyle == .big) ? .small : .big
    }
}
