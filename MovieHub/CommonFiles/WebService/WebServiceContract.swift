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
