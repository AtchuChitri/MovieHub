//
//  GenreList.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation

 struct GenreList:Codable {
     let genres: [genre]
}

struct genre: Codable {
    let id: Int
    let name: String
}
