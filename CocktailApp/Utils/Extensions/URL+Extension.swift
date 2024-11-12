
import Foundation
extension URL {
    func appendingQueryItems(_ items: [URLQueryItem]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        components.queryItems = (components.queryItems ?? []) + items
        return components.url ?? self
    }
}
