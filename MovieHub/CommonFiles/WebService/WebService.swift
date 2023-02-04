//
//  WebService.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation

public struct WebService: WebServiceContract {

    public func processWebService(request: WebServiceRequest) {
        guard let url = getURLRequest(request: request) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                print(data)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
    }
    
    private func getURLRequest(request: WebServiceRequest) -> URL? {
        var components = URLComponents()
        components.scheme = APIHost.scheme
        components.host = APIHost.host
        components.path = request.endPoint.getEndPoint()
        if let param = request.pathParm {
            components.path = request.endPoint.getEndPoint() + "/\(param)"
        }
        for (key, value) in request.parameters {
            components.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        return components.url
    }
}
