//
//  BaseCoordinator.swift
//  MovieHub
//
//  Created by Atchu on 3/2/23.
//

import Foundation
import UIKit

class BaseCoordinator: BaseCoordinatorContract {
    weak public var parentCoordinator: BaseCoordinatorContract?
    public var children: [BaseCoordinatorContract] = []
    public var navigationController: UINavigationController
    private var navigationStack: [UIViewController] = []
    public var tabViewController: UITabBarController?
    
    public init(navigationController: UINavigationController,
                tabViewController:UITabBarController? = nil ) {
        self.navigationController = navigationController
        self.tabViewController = tabViewController
    }
    
   public func start() {
        fatalError("Children should implement `start`.")
    }
    
   public func show(_ viewController: UIViewController, animated: Bool) {
        // yet to start
    }
    
    public func store(coordinator: BaseCoordinatorContract) {
        children.append(coordinator)
    }

    public func free(coordinator: BaseCoordinatorContract) {
        if let index = children.firstIndex( where: { $0 === coordinator }) {
        children.remove(at: index)
        }
    }
    
}
