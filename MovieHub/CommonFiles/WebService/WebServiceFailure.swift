//
//  WebServiceFailure.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation

public enum WebServiceError: Error, Equatable {
    case invalidUrl
    case apiError(WebServiceAPIError)
    case error(code: Int? = 0, message: String?)
}
public struct WebServiceAPIError: Error, Equatable, Codable {
    public struct APIError: Equatable, Codable {
        public let statusCode: String?
        public let statusMessage: String?
        
        enum CodingKeys: String, CodingKey {
            case statusCode = "status_code"
            case statusMessage = "status_message"
        }
    }

    public let errors: [APIError]
}
