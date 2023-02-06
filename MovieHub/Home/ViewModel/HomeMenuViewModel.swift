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
    var bag = Set<AnyCancellable>()
    var dataSource = [MovieModel]()
    var reloadList = PassthroughSubject<Bool, Never>()
    var topMenuSource = ["Now Playing","Popular","Top Rated","Upcoming"]
    var selectedMenu = HomeMenuTopSections.nowPlaying
    private var totalRecords: Int = 0
    var page: Int = 1
    // MARK: - Init webService
    public init(webService: WebServiceContract) {
        self.webService = webService
        fetchTopMenuList(.nowPlaying,1)
    }
}

extension HomeMenuViewModel {
    func fetchTopMenuList(_ section: HomeMenuTopSections, _ page: Int = 1) {
        if selectedMenu != section {
            self.dataSource.removeAll()
            selectedMenu = section
        }
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
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: apiEndPoint, page: page), as: moviesModel.self).sink { _ in
        } receiveValue: { model in
            self.totalRecords = model.totalRecords
            if let results = model.results {
                self.dataSource.append(contentsOf: results)
                self.reloadList.send(true)
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
    
    func fetchImage(url: String) -> ImgDownloaderFuture {
            return webService.getImageFromURL(url: url)
    }
    
}

extension HomeMenuViewModel {
    func getIndexValue(index: Int) -> MovieModel {
        return self.dataSource[index]
    }
    func getTopMenuItem(index: Int) -> String {
        return topMenuSource[index]
    }
    func getSelectedItem(index: Int) -> Bool {
        return selectedMenu.rawValue == index
    }
    
    func checkReloadList() -> Bool {
        return dataSource.count == self.totalRecords
    }
}

extension HomeMenuViewModel {
    
}
