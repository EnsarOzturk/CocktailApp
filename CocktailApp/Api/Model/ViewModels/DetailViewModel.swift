//
//  DetailViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 2.05.2024.
//

import Foundation
class DetailsViewModel {
    private let networkManager: NetworkManager
        private var cocktailId: String?

        init(networkManager: NetworkManager, cocktailId: String?) {
            self.networkManager = networkManager
            self.cocktailId = cocktailId
        }

        func fetchCocktailDetails(completion: @escaping (Result<CocktailDetail, Error>) -> Void) {
            if let cocktailId = cocktailId {
                let endpoint = DetailEndpointItem.cocktailDetails(cocktailID: cocktailId)
                networkManager.request(type: CocktailDetailResponse.self, item: endpoint) { result in
                    switch result {
                    case .success(let response):
                        if let drink = response.drinks.first {
                            completion(.success(drink))
                        } else {
                            completion(.failure(NetworkError.noData))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NetworkError.invalidParameters))
            }
        }
}

