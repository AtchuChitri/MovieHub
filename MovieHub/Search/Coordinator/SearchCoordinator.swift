//
//  SearchCoordinator.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation
import UIKit
import Combine

class SearchCoordinator: BaseCoordinator {
    private var bag = Set<AnyCancellable>()

    override func start() {
        showSearch()
    }
    
    func showSearch() {
        let model = SearchViewModel(webService: WebService())
        model.movieSelected.sink {[weak self] events in
            guard let self = self else { return }
            switch events {
            case .movieDetail(let movieId):
                self.showMovieDetail(movieId)
            }
        }.store(in:&bag)
        let searchVC = SearchViewController(viewModel: model)
        self.navigationController.setViewControllers([searchVC], animated: true)
        self.navigationController.title = "Search"
        self.navigationController.tabBarItem.image = UIImage.init(named: "search")
        self.tabViewController?.viewControllers?.append(self.navigationController)
    }

    func showMovieDetail(_ id: Int) {
        let detailModel = MovieDetailViewModel(webService: WebService(), movieId: id)
        detailModel.eventCallBack.sink { event in
            if event == .back {
                self.pop()
            }
        }.store(in: &bag)
        let detailVC = MovieDetailViewController(viewModel: detailModel)
        self.show(detailVC, animated: true)
    }
}
