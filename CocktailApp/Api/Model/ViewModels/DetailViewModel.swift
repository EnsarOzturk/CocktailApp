
import Foundation
import Alamofire

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var cocktailId: String? { get set }
    func fetchCocktailDetails(completion: @escaping (Result<CocktailDetail, NetworkError>) -> Void)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    private let networkManager: NetworkManager
    var cocktailId: String?
    
    init(networkManager: NetworkManager, cocktailId: String?) {
        self.networkManager = networkManager
        self.cocktailId = cocktailId
    }

    func fetchCocktailDetails(completion: @escaping (Result<CocktailDetail, NetworkError>) -> Void) {
        guard let cocktailId = cocktailId else {
            completion(.failure(.invalidParameters))
            return
        }
        
        let endpoint = DetailEndpointItem.cocktailDetails(cocktailID: cocktailId)
        networkManager.request(type: CocktailDetailResponse.self, item: endpoint) { result in
            switch result {
            case .success(let response):
                if let drink = response.drinks.first {
                    completion(.success(drink))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                // Map Alamofire errors to specific NetworkError cases
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
                    completion(.failure(.requestFailed))
                }
            }
        }
    }
}

