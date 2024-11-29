//
//  CategoryViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 14.03.2024.
//

import Foundation
import Alamofire

protocol CategoryViewModelProtocol: AnyObject {
    var numberOfCategories: Int { get }
    func fetchCategories()
    func getCategory(at index: Int) -> Category?
}

final class CategoryViewModel: CategoryViewModelProtocol {
    private let networkManager: NetworkManager
    private var categories: [Category] = []
    weak var view: CategoryViewProtocol?
    
    init(networkManager: NetworkManager, view: CategoryViewProtocol) {
        self.networkManager = networkManager
        self.view = view
    }
    
    var numberOfCategories: Int {
         categories.count
    }
    
    func getCategory(at index: Int) -> Category? {
        guard index >= 0, index < categories.count else { return nil }
        
        return categories[index]
    }
    
    func fetchCategories() {
        
        networkManager.request(type: CategoryResponse.self, item: CategoryEndpointItem()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.categories = response.drinks ?? []
                self.view?.reloadData()
                    
            case .failure(let error):
                let networkError = self.convertAFErrorToNetworkError(error)
                self.view?.displayError("Error fetching categories: \(networkError.localizedDescription)")
            }
        }
    }
        
    // AFError'ı NetworkError türüne dönüştüren yardımcı fonksiyon
    private func convertAFErrorToNetworkError(_ error: Error) -> NetworkError {
        if let afError = error as? AFError {
            switch afError {
            case .invalidURL:
                return .invalidParameters
            case .responseSerializationFailed:
                return .requestFailed
            default:
                return .requestFailed
            }
        }
        return .requestFailed // Diğer durumlar için genel bir hata
    }
}
