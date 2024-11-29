
import Foundation

enum NetworkError: Error {
    case noData
    case invalidParameters
    case requestFailed
    case decodingFailed
    case invalidURL
    case decodingError
    case unknownError
    case custom(message: String)
}
