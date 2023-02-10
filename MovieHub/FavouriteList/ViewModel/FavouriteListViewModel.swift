//
//  FavouriteListModel.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import Foundation
import Combine

class FavouriteListViewModel: FavouriteListViewModelContract {
    private let coreData: CoreDataProviderContract
    private let webService: WebServiceContract
    var dataSource = [MovieDetail]()
    var bag = Set<AnyCancellable>()
    var reloadList = PassthroughSubject<Bool, Never>()
    var movieSelected = PassthroughSubject<MovieOptionEvents, Never>()

    // MARK: - Init webService
    public init(webService: WebServiceContract) {
        self.webService = webService
        self.coreData = CoreDataProvider()
    }
}
extension FavouriteListViewModel {
    func getIndexValue(index: Int) -> MovieDetail {
        guard let model = dataSource[safeIndex: index] else {
            fatalError("dataSource was not found at index \(index)")
        }
        return model
    }
    func getReleaseDate(_ date: String?) -> String? {
        return date?.getDateString()
    }
}

extension FavouriteListViewModel {
    func getFavouriteList() {
        self.coreData.getAllFavourites().sink { [weak self] list in
            guard let self = self else { return }
            if let model = list {
                self.dataSource = model
                self.reloadList.send(true)
            }
        }.store(in: &bag)
    }
    func fetchImage(url: String) -> ImgDownloaderFuture {
            return webService.getImageFromURL(url: url)
    }
}
