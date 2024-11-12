
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
                if response.data == nil {
                    completion(.failure(.noData))
                } else {
                    completion(.failure(.requestFailed))
                }
            }
        }
    }
}

