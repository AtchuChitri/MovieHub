//
//  MovieDetailViewModel.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation
import Combine

class MovieDetailViewModel: MovieDetailViewModelContract {
    private let webService: WebServiceContract
    private let coreData: CoreDataProviderContract
    var dataSource:MovieDetailModel?
    private let movieId: Int
    var bag = Set<AnyCancellable>()
    var eventAction = PassthroughSubject<ScreenActionEvent, Never>()
    var eventCallBack = PassthroughSubject<DetailScreenCallBack, Never>()
    var isFavioute: Bool = false


    // MARK: - Init webService
    public init(webService: WebServiceContract, movieId: Int) {
        self.webService = webService
        self.movieId = movieId
        self.coreData = CoreDataProvider()
    }
}

extension MovieDetailViewModel {
    func fetchMovieDetails() {
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: .detail(.moveDetail),pathParm: "\(movieId)"), as: MovieDetailModel.self).sink { _ in
        } receiveValue: { [weak self] model in
            guard let self = self else { return }
            self.dataSource = model
            self.isFavioute = self.coreData.isMovieExist(model.id)
            self.eventAction.send(.reload)
        }.store(in: &bag)

    }
    
    func fetchImage(url: String) -> ImgDownloaderFuture {
            return webService.getImageFromURL(url: url)
    }
}

extension MovieDetailViewModel {
    func fetchGenre() -> String? {
        self.dataSource?.genres.map{$0.name}.joined(separator: ",")
    }
    func getRunTime() -> String? {
        let runtime = (dataSource?.runtime ?? 0) * 60
        return runtime.asString(style: .brief)
    }
    func getReleaseDate() -> String? {
        return dataSource?.releaseDate?.getDateString()
    }
    func getAdult() -> String {
        return dataSource?.adult ?? false ? "PG18" : "PG13"
    }
    func getSpokenLanguage() -> String? {
        return dataSource?.spokenLanguages?.map{$0.name ?? ""}.joined(separator: ",")
    }
}

extension MovieDetailViewModel {
    
    func makeFavourite() {
        if let data = dataSource, !isFavioute {
            self.coreData.makeFavourite(data).sink { value in
                if value {
                    self.isFavioute = self.coreData.isMovieExist(data.id)
                    self.eventAction.send(.saveRecord)
                }
                print(value ? "Saved": "failed")
            }.store(in: &bag)
        } else {
            if let data = dataSource {
                self.coreData.deleteRecord(data.id)
                self.isFavioute = self.coreData.isMovieExist(data.id)
                self.eventAction.send(.deletedRecord)
            }
        }
    }
}
