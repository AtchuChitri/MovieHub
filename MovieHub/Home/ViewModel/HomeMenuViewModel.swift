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
    var dataSource = [MovieModel]()
    var reloadList = PassthroughSubject<Bool, Never>()
    
    // MARK: - Init webService
    public init(webService: WebServiceContract) {
        self.webService = webService
        fetchTopMenuList(.topRated,1)
    }
    
    func fetchTopMenuList(_ section: HomeMenuTopSections, _ page: Int = 1) {
        var apiEndPoint: ApiEndpoint
        switch section {
        case .nowPlaying:
            apiEndPoint = .movie(.nowPlaying)
        case .popular:
            apiEndPoint = .movie(.popular)
        case .topRated:
            apiEndPoint = .movie(.topRated)
        case .upcoming:
            apiEndPoint = .movie(.upComing)
        }
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: apiEndPoint), as: moviesModel.self).sink { _ in
        } receiveValue: { model in
            if let results = model.results {
                self.dataSource.append(contentsOf: results)
            }
        }.store(in: &bag)
        
    }
    
    func fetchGenreList() {
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: .genre(.genre)), as: GenreList.self).sink { errorResponse in
            print(errorResponse)
        } receiveValue: { genreList in
            print(genreList)
        }.store(in: &bag)
        
    }
}
