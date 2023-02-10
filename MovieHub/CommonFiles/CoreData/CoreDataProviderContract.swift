//
//  CoreDataProviderContract.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import Foundation
import Combine

protocol CoreDataProviderContract {
    func makeFavourite(_ detail: MovieDetailModel) -> Future<Bool, Never>
    func isMovieExist(_ id: Double) -> Bool
    func getAllFavourites() -> Future<[MovieDetail]?, Never>
    func deleteRecord(_ id: Double)
}
