//
//  ListViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 15.03.2024.
//
import Foundation
import Alamofire

protocol ListViewModelProtocol: AnyObject {
    var numberOfDrinks: Int { get }
    func getDrink(at index: Int) -> Drink?
    func fetchDrinks(completion: @escaping (Result<Void, NetworkError>) -> Void)
}

final class ListViewModel: ListViewModelProtocol {
    private let networkManager: NetworkManager
    private var drinks: [Drink] = []
    private var selectedCategory: Category?
    
    init(networkManager: NetworkManager, category: Category) {
        self.networkManager = networkManager
        self.selectedCategory = category
    }
    
    var numberOfDrinks: Int{
        drinks.count
    }
    
    func getDrink(at index: Int) -> Drink? {
        guard index >= 0, index < drinks.count else { return nil }
            return drinks[index]
    }
    
    func fetchDrinks(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        
        guard let categoryName = selectedCategory?.strCategory else {
            completion(.failure(.invalidParameters))
            return
        }
            
        let endpoint = ListEndpointItem(category: categoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        networkManager.request(type: ListResponse.self, item: endpoint) { result in
            switch result {
            case .success(let response):
                if let drinks = response.drinks {
                    self.drinks = drinks
                    completion(.success(()))
                } else {
                    completion(.failure(.noData))
                }
                    
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
}

