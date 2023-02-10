//
//  CoreDataProvider.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import Foundation
import CoreData
import Combine

class CoreDataProvider: CoreDataProviderContract {
    let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    
    func makeFavourite(_ detail: MovieDetailModel) -> Future<Bool, Never> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            let movie = MovieDetail(context: self.managedContext)
            movie.setValue(detail.id, forKey: "id")
            movie.setValue(detail.backdropPath, forKey: "backdropPath")
            movie.setValue(detail.posterPath, forKey: "posterPath")
            movie.setValue(detail.title, forKey: "title")
            movie.setValue(detail.tagline, forKey: "tagline")
            movie.setValue(detail.revenue, forKey: "revenue")
            movie.setValue(detail.budget, forKey: "budget")
            movie.setValue(detail.status, forKey: "status")
            movie.setValue(detail.voteAverage, forKey: "voteAverage")
            movie.setValue(detail.voteCount, forKey: "voteCount")
            movie.setValue(detail.releaseDate, forKey: "releaseDate")
            movie.setValue(detail.runtime, forKey: "runtime")
            movie.setValue(detail.adult, forKey: "adult")
            movie.setValue(detail.overview, forKey: "overview")
            movie.setValue(detail.originalLanguage, forKey: "originalLanguage")
            movie.setValue(detail.genres.map{$0.id}, forKey: "genres")
            do {
                try self.managedContext.save()
                promise(.success(true))
            } catch {
                print("Unable to Save Book, \(error)")
                promise(.success(false))
            }
        }
    }
    
    func isMovieExist(_ id: Double) -> Bool {
        if let _ = fetchRecord(id) {
            return true
        }
        return false
    }
    
    func getAllFavourites() -> Future<[MovieDetail]?, Never> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            let request: NSFetchRequest<MovieDetail> = MovieDetail.fetchRequest()
            if let objects = try? self.managedContext.fetch(request) {
                promise(.success(objects))
            } else {
                promise(.success(nil))
            }

        }

    }
    private func fetchRecord(_ id: Double) -> MovieDetail? {
        let request: NSFetchRequest<MovieDetail> = MovieDetail.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", "\(id)")
        do {
            let fetchedResults = try managedContext.fetch(request)
            if let model = fetchedResults.first {
                return model
            }
        } catch {
            print("Unable to fetch, \(error)")
        }
        return nil
    }
    func deleteRecord(_ id: Double) {
        if let item = fetchRecord(id) {
            managedContext.delete(item)
        }
    }
}
