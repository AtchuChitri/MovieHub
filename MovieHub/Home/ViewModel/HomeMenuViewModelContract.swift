//
//  HomeMenuViewModelContract.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import Combine

protocol HomeMenuViewModelContract {
    var dataSource: [MovieModel] { get set }
    var reloadList: PassthroughSubject<Bool, Never> { get set }
    var topMenuSource: [String] { get set }
    var selectedMenu:HomeMenuTopSections { get set }
    var page:Int { get set }
    
    func getIndexValue(index: Int) -> MovieModel
    func fetchTopMenuList(_ section: HomeMenuTopSections, _ page: Int)
    func fetchImage(url: String) -> ImgDownloaderFuture
    func getTopMenuItem(index: Int) -> String
    func getSelectedItem(index: Int) -> Bool
    func checkReloadList() -> Bool
}

// Home Menu Sections
enum HomeMenuTopSections: Int {
    case nowPlaying
    case popular
    case topRated
    case upcoming
}
