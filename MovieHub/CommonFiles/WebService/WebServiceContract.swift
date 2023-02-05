//
//  WebServiceContract.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation
import Combine

public protocol WebServiceContract {
    
    func processWebService<T: Codable>(request: WebServiceRequest, as type: T.Type) -> Future<T, WebServiceError>
}

//extension WebServiceContract {
//            /// Convenience override on `process` web service request function to 'decode' a 'json' result into an expected `JsonResponseModel`
//        ///
//        /// *Note*:
//        /// - Expected `JsonResponseModel` must be a `Decodable`
//        ///
//        /// - Parameters:
//        ///   - webServiceRequest: web service request
//        ///   - type: a `Decodable` `JsonResponseModel` type to parse json web service response into
//        /// - Returns: a publisher of decoded JsonResponseModel result, or error
//        func process<JsonResponseModel>(webServiceRequest: WebServiceRequest,
//                                        as type: JsonResponseModel.Type) -> Future<JsonResponseModel, WebServiceError>
//        where JsonResponseModel: Decodable {
//            return Future { promise in
//
//                self.processWebService(request: webServiceRequest).sink { webServiceError in
//
//                } receiveValue: { response in
//
//                }
//
//
//                self.process(webServiceRequest: webServiceRequest) { result in
//                    switch result {
//                    case .success(let webServiceResponse):
//                        let decodeResult = self.decode(response: webServiceResponse, as: type)
//                        switch decodeResult {
//                        case .success(let responseModel):
//                            promise(.success(responseModel))
//                        case .failure(let webServiceError):
//                            promise(.failure(webServiceError))
//                        }
//                    case .failure(let webServiceError):
//                        promise(.failure(webServiceError))
//                    }
//                }
//            }
//        }
//}
