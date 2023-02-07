//
//  ApiEndpoint.swift
//  MovieHub
//
//  Created by Atchu on 4/2/23.
//

import Foundation

public struct APIHost {
    static let scheme = "https"
    static let host = "api.themoviedb.org"
}

public enum ApiEndpoint: Equatable {
    case movie(Movie)
    case genre(Genre)
    case detail(Details)
    case search(Search)
    
    func getEndPoint() -> String {
        switch self {
        case .movie(let movie):
            return movie.rawValue
        case .genre(let genre):
            return genre.rawValue
        case .detail(let detail):
            return detail.rawValue
        case .search(let search):
            return search.rawValue
        }
    }
}

public enum Movie: String {
    case nowPlaying = "/3/movie/now_playing"
    case popular = "/3/movie/popular"
    case topRated = "/3/movie/top_rated"
    case upComing = "/3/movie/upcoming"
}

public enum Genre: String {
    case genre = "/3/genre/movie/list"
}

public enum Details: String {
    case moveDetail = "/3/movie/"
}

public enum Search: String {
    case search = "/3/search/movie"
}
