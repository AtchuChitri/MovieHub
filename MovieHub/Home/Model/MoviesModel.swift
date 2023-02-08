//
//  MovieList.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation

struct moviesModel: Codable {
    let page: Int
    let results: [MovieModel]?
    let totalRecords: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalRecords = "total_results"
    }
}

struct MovieModel: Codable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let overview: String?
    let originalTitle: String?
    let poster: String?
    let genreIds: [Int]?
    let voteAverage : Float?
    let voteCount: Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case poster = "poster_path"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}
