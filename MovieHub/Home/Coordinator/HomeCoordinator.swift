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
        let viewModel = HomeMenuViewModel()
        let homeVC = HomeMenuViewController(viewModel: viewModel)
        self.navigationController.setViewControllers([homeVC], animated: true)
        self.navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage.init(named: "home")
        let searchNavigation = UINavigationController(rootViewController: UIViewController())
        searchNavigation.title = "Search"
        searchNavigation.tabBarItem.image = UIImage.init(named: "search")
        self.tabViewController?.setViewControllers([navigationController,searchNavigation], animated: false)
    }
}
