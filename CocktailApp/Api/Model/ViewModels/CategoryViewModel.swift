//
//  CategoryViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 14.03.2024.
//

import Foundation

class CategoryViewModel {
    private let networkManager: NetworkManager
    private var categories: [Category] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        networkManager.request(type: CategoryResponse.self, item: CategoryEndpointItem()) { result in
            switch result {
            case .success(let response):
                if let categories = response.drinks {
                    self.categories = categories
                    completion(.success(categories))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCategory(at index: Int) -> Category? {
           guard index >= 0, index < categories.count else {
               return nil
           }
           return categories[index]
    }
    
    func numberOfCategories() -> Int {
            return categories.count
    }
}
