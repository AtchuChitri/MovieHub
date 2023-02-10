//
//  FavouriteListViewModelContract.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import Foundation
import Combine

protocol FavouriteListViewModelContract {
    var dataSource: [MovieDetail] { get set }
    var reloadList:PassthroughSubject<Bool, Never> { get set }
    var movieSelected: PassthroughSubject<MovieOptionEvents, Never> { get set }
    func getGenre(_ genreId: [Int]) -> String?
    
    func getIndexValue(index: Int) -> MovieDetail
    func fetchImage(url: String) -> ImgDownloaderFuture
    func getReleaseDate(_ date: String?) -> String?
    func getFavouriteList()
}
