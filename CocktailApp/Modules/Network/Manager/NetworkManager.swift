//
//  NetworkManager.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    func request<T: Codable>(type: T.Type, item: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(item.url, method: item.method).responseData { response in
            switch response.result {
            case .success(let data):
                let jsonString = String(data: data, encoding: .utf8)
                
                guard !data.isEmpty else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.requestFailed))
                }
            case .failure:
                completion(.failure(.requestFailed))
            }
        }
    }
}

