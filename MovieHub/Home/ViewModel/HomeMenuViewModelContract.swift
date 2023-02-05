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
}

// Home Menu Sections
enum HomeMenuTopSections: Int {
    case nowPlaying
    case popular
    case topRated
    case upcoming
}
