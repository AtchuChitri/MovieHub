//
//  WebServiceContract.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation
import Combine

public protocol WebServiceContract {
    
    func processWebService(request: WebServiceRequest) -> Future<WebServiceResponse, WebServiceError>
}
