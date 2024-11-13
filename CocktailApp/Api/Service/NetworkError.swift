
import Foundation

enum NetworkError: Error {
    case noData
    case invalidParameters
    case requestFailed
    case decodingFailed
    case custom(message: String)
}
