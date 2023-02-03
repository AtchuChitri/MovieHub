//
//  WebServiceRequest.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation

let defaultKey = "&api_key=0e7274f05c36db12cbe71d9ab0393d47"
public struct WebServiceRequest: Equatable {
    
    public enum HttpMethod: String {
        /// `GET` method.
        case get = "GET"
    }
    let endPoint: String
    var parameters:[String]
    let method: WebServiceRequest.HttpMethod
    
    public init(apiEndpoint: String,
                method: WebServiceRequest.HttpMethod = .get,
                pathParameters: [String] = []) {
        self.endPoint = apiEndpoint
        self.method = method
        self.parameters = pathParameters
        self.parameters.append(defaultKey)
    }
}
