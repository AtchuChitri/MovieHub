//
//  WebServiceResponse.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation

public struct WebServiceResponse: Equatable {
    public let data: Data?

    init(data: Data?) {
        self.data = data
    }
}
