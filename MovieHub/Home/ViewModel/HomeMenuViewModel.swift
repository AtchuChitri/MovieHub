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
    var reloadList = PassthroughSubject<ScreenActionEvent, Never>()
    var topMenuSource = ["Now Playing","Popular","Top Rated","Upcoming"]
    var selectedMenu = HomeMenuTopSections.nowPlaying
    private var totalRecords: Int = 0
    var page: Int = 1
    private var sharedInstance = MovieGenreManger.shared
    var movieSelected = PassthroughSubject<MovieOptionEvents, Never>()

    
    // MARK: - Init webService
    public init(webService: WebServiceContract) {
        self.webService = webService
    }
}

extension HomeMenuViewModel {
    func fetchTopMenuList(_ section: HomeMenuTopSections, _ page: Int = 1) {
        if selectedMenu != section {
            self.dataSource.removeAll()
            selectedMenu = section
        }
        self.page = page
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
      
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: apiEndPoint, page: page), as: moviesModel.self).subscribe(on: DispatchQueue.global(qos: .userInitiated)).sink { _ in
            } receiveValue: { [weak self] model in
                self?.totalRecords = model.totalRecords
                if let results = model.results {
                    DispatchQueue.main.async {
                        self?.dataSource.append(contentsOf: results)
                        self?.reloadList.send(.reload)
                        self?.reloadList.send(.stopLoader)
                    }
                 
                }
            }.store(in: &self.bag)
       
        
    }
    
    func fetchGenreList() {
        self.reloadList.send(.startLoader)
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: .genre(.genre)), as: GenreList.self).subscribe(on: DispatchQueue.global()).sink { errorResponse in
            print(errorResponse)
        } receiveValue: { [weak self] genreList in
            guard let self = self else { return }
            self.sharedInstance.updateGenreList(genreList.genres)
            self.fetchTopMenuList(.nowPlaying,1)
        }.store(in: &bag)
        
    }
    
    func fetchImage(url: String) -> ImgDownloaderFuture {
            return webService.getImageFromURL(url: url)
    }
    
}

extension HomeMenuViewModel {
    func getIndexValue(index: Int) -> MovieModel {
        guard let model = dataSource[safeIndex: index] else {
            fatalError("dataSource was not found at index \(index)")
        }
        return model
    }
    func getTopMenuItem(index: Int) -> String {
        return topMenuSource[index]
    }
    func getSelectedItem(index: Int) -> Bool {
        return selectedMenu.rawValue == index
    }
    
    func checkReloadList() -> Bool {
        return dataSource.count != self.totalRecords
    }
    func getGenre(_ genreId: [Int]) -> String? {
      return sharedInstance.fetchGenreStr(genreId)
    }
}

extension HomeMenuViewModel {
    
}
