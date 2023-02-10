//
//  FavouriteCoordinator.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import Foundation
import UIKit
import Combine

class FavouriteCoordinator: BaseCoordinator {
    private var bag = Set<AnyCancellable>()

    override func start() {
        showFavourite()
    }
    
    func showFavourite() {
        let model = FavouriteListViewModel(webService: WebService())
        model.movieSelected.sink {[weak self] events in
            guard let self = self else { return }
            switch events {
            case .movieDetail(let movieId):
                self.showMovieDetail(movieId)
            }
        }.store(in:&bag)
        let FavouriteVC = FavouriteListViewController(viewModel: model)
        self.navigationController.setViewControllers([FavouriteVC], animated: true)
        self.navigationController.title = "Favourite"
        self.navigationController.tabBarItem.image = UIImage.init(named: "favorites")
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
