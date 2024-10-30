
//  RandomViewModel.swift
//  CocktailApp
//
//  Created by Ensar on 2.05.2024.
//
import Foundation
import Combine

class RandomCocktailViewModel: ObservableObject {
    private let randomCocktailService: RandomCocktailService
    @Published var randomCocktail: RandomCocktail? // SwiftUI'yi güncellemeyi sağlayan değişiklik

    init(randomCocktailService: RandomCocktailService) {
        self.randomCocktailService = randomCocktailService
    }

    func fetchRandomCocktail(completion: ((Result<RandomCocktail, Error>) -> Void)? = nil) {
        randomCocktailService.getRandomCocktail { [weak self] result in
            switch result {
            case .success(let randomCocktailResponse):
                if let randomCocktail = randomCocktailResponse.drinks.first {
                    DispatchQueue.main.async {
                        self?.randomCocktail = randomCocktail
                        completion?(.success(randomCocktail))
                    }
                } else {
                    completion?(.failure(NetworkError.noData))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}


