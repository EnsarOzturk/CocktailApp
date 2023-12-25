//
//  URL+Extension.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

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
