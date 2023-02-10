//
//  MovieDetailModel.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation

struct MovieDetailModel: Codable {
    let backdropPath: String?
    let budget: Double?
    let genres: [genre]
    let originalLanguage: String?
    let overview: String?
    let posterPath: String?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let voteAverage: Float?
    let voteCount: Float?
    let releaseDate: String?
    let runtime: Double?
    let adult: Bool?
    let revenue: Double?
    let id: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case runtime
        case adult
        case revenue
        case id
        
        
        
    }
}

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso = "iso_639_1"
        case name
    }
}
