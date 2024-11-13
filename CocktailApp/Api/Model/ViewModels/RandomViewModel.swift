
import Foundation
import Alamofire

final class RandomCocktailViewModel {
    private let randomCocktailService: RandomCocktailService
    var randomCocktail: RandomCocktail?

    init(randomCocktailService: RandomCocktailService) {
        self.randomCocktailService = randomCocktailService
    }

    // Fetch a random cocktail from the service
    func fetchRandomCocktail(completion: @escaping (Result<RandomCocktail, NetworkError>) -> Void) {
        randomCocktailService.getRandomCocktail { result in
            switch result {
            case .success(let randomCocktailResponse):
                // Ensure we have a drink
                if let randomCocktail = randomCocktailResponse.drinks.first {
                    self.randomCocktail = randomCocktail
                    completion(.success(randomCocktail))
                } else {
                    completion(.failure(.noData)) // No data found
                }
            case .failure(let error):
                // Handle Alamofire errors
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
                    completion(.failure(.requestFailed)) // Generic error
                }
            }
        }
    }
}
