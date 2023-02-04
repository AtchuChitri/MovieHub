//
//  WebService.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation
import Combine

public struct WebService: WebServiceContract {

    public func processWebService(request: WebServiceRequest) -> Future<WebServiceResponse, WebServiceError> {
        return Future { promise in
            guard let url = getURLRequest(request: request) else { return promise(.failure(.invalidUrl))}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                 if let responseData = data,
                    let errorResonse = try? JSONDecoder().decode(WebServiceAPIError.self, from: responseData) {
                     promise(.failure(WebServiceError.apiError(errorResonse)))
                 }
                 if let responseData = data {
                      promise(.success(WebServiceResponse(data: responseData)))
                 } else {
                      promise(.failure(.invalidUrl))
                 }
            }.resume()
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
