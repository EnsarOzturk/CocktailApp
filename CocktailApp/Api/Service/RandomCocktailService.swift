//
//  RandomCocktailService.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

import Foundation
import Alamofire

class RandomCocktailService {
    func getRandomCocktail(completion: @escaping (Result<RandomCocktailResponse, Error>) -> Void) {
        let endpoint = RandomCocktailEndpointItem()
        AF.request(endpoint.url, method: endpoint.method).validate().responseDecodable(of: RandomCocktailResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
