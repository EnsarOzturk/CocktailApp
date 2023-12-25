//
//  NetworkManager.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    func request<T: Codable>(type: T.Type, item: Endpoint, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(item.url, method: item.method).responseData { response in

            switch response.result {
            case .success(let data):
                print(response.request?.url)
                print(item.path)
                let jsonString = String(data: data, encoding: .utf8)
                print("API Response: \(jsonString ?? "No Data")")
                let response = try! JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            case .failure(let error):
                print("error\(error)")
                completion(.failure(error))

            }
        }
    }
}
