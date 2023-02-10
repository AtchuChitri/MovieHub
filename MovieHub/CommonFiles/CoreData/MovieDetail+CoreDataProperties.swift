//
//  MovieDetail+CoreDataProperties.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//
//

import Foundation
import CoreData


extension MovieDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetail> {
        return NSFetchRequest<MovieDetail>(entityName: "MovieDetail")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var budget: Double
    @NSManaged public var id: Double
    @NSManaged public var originalLanguage: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var revenue: Double
    @NSManaged public var runtime: Double
    @NSManaged public var status: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var voteCount: Float

}

extension MovieDetail : Identifiable {

}
