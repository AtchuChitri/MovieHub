//
//  SearchViewModel.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation
import Combine

class SearchViewModel: SearchViewModelContract {
    // MARK: - properties
    private let webService: WebServiceContract
    var bag = Set<AnyCancellable>()
    var dataSource = [MovieModel]()
    var reloadList = PassthroughSubject<SearchScreenActionEvent, Never>()
    private var totalRecords: Int = 0
    var page: Int = 1
    var searchText: String = ""

    // MARK: - Init webService
    public init(webService: WebServiceContract) {
        self.webService = webService
    }
}

extension SearchViewModel {
    func fetchSearchResults(_ query: String, _ page:Int = 1) {
        if searchText != query {
            searchText = query
            self.dataSource.removeAll()
        }
        self.page = page
        self.webService.processWebService(request: WebServiceRequest(apiEndpoint: .search(.search), pathParameters: ["query": query], page: page), as: moviesModel.self).sink { error in
            self.reloadList.send(.reload)
        } receiveValue: { movies in
            self.totalRecords = movies.totalRecords
            if let results = movies.results {
                print(results.map{$0.title})
                self.dataSource.append(contentsOf: results)
                self.reloadList.send(.reload)
            }
        }.store(in: &bag)

    }
    func fetchImage(url: String) -> ImgDownloaderFuture {
            return webService.getImageFromURL(url: url)
    }
}

extension SearchViewModel {
    func getIndexValue(index: Int) -> MovieModel {
        return self.dataSource[index]
    }
    func checkReloadList() -> Bool {
        return dataSource.count != self.totalRecords
    }
    
}

