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
    var dataSource:MovieDetailModel?
    private let movieId: Int
    var bag = Set<AnyCancellable>()
    var eventAction = PassthroughSubject<ScreenActionEvent, Never>()
    var eventCallBack = PassthroughSubject<DetailScreenCallBack, Never>()


    // MARK: - Init webService
    public init(webService: WebServiceContract, movieId: Int) {
        self.webService = webService
        self.movieId = movieId
    }
}

extension MovieDetailViewModel {
    func fetchMovieDetails() {
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: .detail(.moveDetail),pathParm: "\(movieId)"), as: MovieDetailModel.self).sink { _ in
        } receiveValue: { model in
            self.dataSource = model
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
