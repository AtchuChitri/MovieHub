//
//  MovieDetailViewModelContract.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation
import Combine

protocol MovieDetailViewModelContract {
    var dataSource:MovieDetailModel? { get set }
    var eventAction: PassthroughSubject<ScreenActionEvent, Never> { get set }
    var eventCallBack: PassthroughSubject<DetailScreenCallBack, Never>{ get set }

    
    func fetchMovieDetails()
    func fetchImage(url: String) -> ImgDownloaderFuture
    func fetchGenre() -> String?
}

enum DetailScreenCallBack {
    case back
}
