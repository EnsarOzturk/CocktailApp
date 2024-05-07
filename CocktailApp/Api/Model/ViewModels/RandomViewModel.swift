//
//  RandomViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 2.05.2024.
//

import Foundation

class RandomCocktailViewModel {
    private let randomCocktailService: RandomCocktailService
    var randomCocktail: RandomCocktail?

    init(randomCocktailService: RandomCocktailService) {
        self.randomCocktailService = randomCocktailService
    }

    func fetchRandomCocktail(completion: @escaping (Result<RandomCocktail, Error>) -> Void) {
        randomCocktailService.getRandomCocktail { result in
            switch result {
            case .success(let randomCocktailResponse):
                if let randomCocktail = randomCocktailResponse.drinks.first {
                    self.randomCocktail = randomCocktail
                    completion(.success(randomCocktail))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                completion(.failure(NetworkError.requestFailed))
            }
        }
    }
}
