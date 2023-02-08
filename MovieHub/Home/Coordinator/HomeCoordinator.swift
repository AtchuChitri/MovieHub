//
//  HomeCoordinator.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import UIKit
import Combine

class HomeCoordinator: BaseCoordinator {
    private var bag = Set<AnyCancellable>()

    override func start() {
        showHomeMenu()
    }
    
    func showHomeMenu() {
        let viewModel = HomeMenuViewModel(webService: WebService())
        viewModel.movieSelected.sink {[weak self] events in
            guard let self = self else { return }
            switch events {
            case .movieDetail(let movieId):
                self.showMovieDetail(movieId)
            }
        }.store(in:&bag)
        let homeVC = HomeMenuViewController(viewModel: viewModel)
        self.navigationController.setViewControllers([homeVC], animated: true)
        self.navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage.init(named: "home")
        self.tabViewController?.setViewControllers([navigationController], animated: false)
        let serachNavigation = UINavigationController()
        let searchC = SearchCoordinator(navigationController: serachNavigation, tabViewController: self.tabViewController)
        searchC.parentCoordinator = self
        searchC.start()
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


