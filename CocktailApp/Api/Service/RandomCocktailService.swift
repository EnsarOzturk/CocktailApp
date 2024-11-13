//
//  RandomCocktailService.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

import Foundation
import Alamofire

class RandomCocktailService {
    func getRandomCocktail(completion: @escaping (Result<RandomCocktailResponse, NetworkError>) -> Void) {
        let endpoint = RandomCocktailEndpointItem()
        
        AF.request(endpoint.url, method: endpoint.method).validate().responseDecodable(of: RandomCocktailResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                // Alamofire hata türünü NetworkError’a çeviriyoruz
                let networkError: NetworkError
                if let afError = error.asAFError {
                    switch afError {
                    case .responseValidationFailed(reason: .dataFileNil):
                        networkError = .noData
                    case .responseSerializationFailed(reason: .decodingFailed):
                        networkError = .decodingFailed
                    default:
                        networkError = .requestFailed
                    }
                } else {
                    networkError = .custom(message: error.localizedDescription)
                }
                completion(.failure(networkError))
            }
        }
    }
}
