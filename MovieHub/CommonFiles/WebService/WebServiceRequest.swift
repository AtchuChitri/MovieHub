//
//  WebServiceRequest.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation


let defaultKey = "0e7274f05c36db12cbe71d9ab0393d47"
public struct WebServiceRequest: Equatable {
    
    public enum HttpMethod: String {
        /// `GET` method.
        case get = "GET"
    }
    let endPoint: ApiEndpoint
    var parameters:[String:String] = ["api_key": defaultKey]
    let method: WebServiceRequest.HttpMethod
    let pathParm: String?
    
    public init(apiEndpoint: ApiEndpoint,
                method: WebServiceRequest.HttpMethod = .get,
                pathParameters: [String:String]? = nil,
                pathParm:String? = nil,
                page: Int = 1) {
        self.endPoint = apiEndpoint
        self.method = method
        self.parameters.updateValue("\(page)", forKey: "page")
        
        if let pathParameters = pathParameters {
            self.parameters = self.parameters.merging(pathParameters) { $1 }
        }
        self.pathParm = pathParm
    }
    
    
    
}
