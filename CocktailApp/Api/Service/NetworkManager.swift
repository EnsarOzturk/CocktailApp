
import Foundation
import Alamofire

class NetworkManager {
    func request<T: Codable>(type: T.Type, item: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(item.url, method: item.method).responseData { response in
            switch response.result {
            case .success(let data):
                print(response.request?.url ?? "")
                print(item.path)
                let jsonString = String(data: data, encoding: .utf8)
                print("API Response: \(jsonString ?? "No Data")")

                // Check if data is empty
                guard !data.isEmpty else {
                    completion(.failure(.noData))
                    return
                }
                // Attempt to decode the data
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(.requestFailed)) // Alternatively, you can add a `decodingFailed` case
                }
                
            case .failure:
                print("Request failed")
                completion(.failure(.requestFailed))
            }
        }
    }
}

