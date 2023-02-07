//
//  MovieGenreManger.swift
//  MovieHub
//
//  Created by Atchu on 7/2/23.
//

import Foundation

final class MovieGenreManger {
    static let shared = MovieGenreManger()
    //Initializer access level change now
    private init(){}
    
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    var genreList: [genre]?
    
    func updateGenreList(_ list: [genre]) {
        concurrentQueue.async(flags: .barrier) {
            self.genreList = list
        }
    }
    
    func fetchGenreStr(_ list: [Int]) -> String? {
        concurrentQueue.sync {
            return self.genreList?.filter{list.contains($0.id)}.map{$0.name}.joined(separator: ",")
        }
    }
        
}
