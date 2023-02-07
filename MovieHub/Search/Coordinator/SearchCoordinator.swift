//
//  SearchCoordinator.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation
import UIKit

class SearchCoordinator: BaseCoordinator {
    
    override func start() {
        showSearch()
    }
    
    func showSearch() {
        let model = SearchViewModel(webService: WebService())
        let searchVC = SearchViewController(viewModel: model)
        self.navigationController.setViewControllers([searchVC], animated: true)
        self.navigationController.title = "Search"
        self.navigationController.tabBarItem.image = UIImage.init(named: "search")
        self.tabViewController?.viewControllers?.append(self.navigationController)
    }
}
