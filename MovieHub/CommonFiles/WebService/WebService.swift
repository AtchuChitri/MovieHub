//
//  WebService.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation
import Combine

public struct WebService: WebServiceContract {

    public func processWebService<T: Codable>(request: WebServiceRequest, as type: T.Type) -> Future<T, WebServiceError> {
        return Future { promise in
            guard let urlStr = getURLRequest(request: request), let url = URL(string: urlStr)  else { return promise(.failure(.invalidUrl))}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                 if let responseData = data,
                    let errorResonse = try? JSONDecoder().decode(WebServiceAPIError.self, from: responseData) {
                     promise(.failure(WebServiceError.apiError(errorResonse)))
                 }
                 if let responseData = data,
                     let sucessResonse = try? JSONDecoder().decode(T.self, from: responseData) {
                         promise(.success(sucessResonse))
                     }
                 else {
                      promise(.failure(.invalidUrl))
                 }
            }.resume()
        }
    }
    
    private func getURLRequest(request: WebServiceRequest) -> String? {
        var components = URLComponents()
        components.scheme = APIHost.scheme
        components.host = APIHost.host
        components.path = request.endPoint.getEndPoint()
        if let param = request.pathParm {
            components.path = request.endPoint.getEndPoint() + "/\(param)"
        }
        components.setQueryItems(with: request.parameters)
        return components.url?.absoluteString
    }
}
