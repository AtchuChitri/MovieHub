//
//  SearchViewModelContract.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation
import Combine

protocol SearchViewModelContract {
    var dataSource: [MovieModel] { get set }
    var reloadList: PassthroughSubject<SearchScreenActionEvent, Never> { get set }
    var searchText: String { get set }
    var page: Int { get set }
    var movieSelected: PassthroughSubject<MovieOptionEvents, Never> { get set }

    func fetchSearchResults(_ query: String, _ page: Int)
    func getIndexValue(index: Int) -> MovieModel
    func fetchImage(url: String) -> ImgDownloaderFuture
    func checkReloadList() -> Bool
    func getGenre(_ genreId: [Int]) -> String? 
}

enum SearchScreenActionEvent {
   case reload
   case startLoader
   case stopLoader
}
