//
//  HomeMenuViewModel.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import Combine

class HomeMenuViewModel: HomeMenuViewModelContract {
    
    // MARK: - properties
    private let webService: WebServiceContract
    private var bag = Set<AnyCancellable>()
    
    // MARK: - Init webService
    public init(webService: WebServiceContract) {
        self.webService = webService
        fetchGenreList()
    }
    
    func fetchGenreList() {
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: .genre(.genre)), as: GenreList.self).sink { errorResponse in
            print(errorResponse)
        } receiveValue: { genreList in
            print(genreList)
        }.store(in: &bag)
        
    }
}
