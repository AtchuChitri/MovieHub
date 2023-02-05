//
//  URLComponents+QueryItem.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
