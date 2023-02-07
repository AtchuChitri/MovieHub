//
//  HomeCoordinator.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import UIKit

class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        showHomeMenu()
    }
    
    func showHomeMenu() {
        let viewModel = HomeMenuViewModel(webService: WebService())
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
}
