//
//  ListViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 15.03.2024.
//

import Foundation

class ListViewModel {
    private let networkManager: NetworkManager
    private var drinks: [Drink] = []
    var selectedCategory: Category?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func setSelectedCategory(_ category: Category) {
            selectedCategory = category
    }
    
    func fetchDrinks(completion: @escaping (Result<[Drink], NetworkError>) -> Void) {
        guard let selectedCategory = selectedCategory,
              let originalCategory = selectedCategory.strCategory else {
            return
        }
        
        let endpoint = ListEndpointItem(category: originalCategory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        networkManager.request(type: ListResponse.self, item: endpoint) { result in
            switch result {
            case .success(let response):
                if let drinks = response.drinks {
                    self.drinks = drinks
                    completion(.success(drinks))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(NetworkError.requestFailed))
                endpoint.handle(error: error)
            }
        }
    }
    
    func numberOfDrinks() -> Int {
            return drinks.count
    }
    
    func getDrink(at index: Int) -> Drink? {
        guard index >= 0, index < drinks.count else {
            return nil
        }
            return drinks[index]
    }
}
