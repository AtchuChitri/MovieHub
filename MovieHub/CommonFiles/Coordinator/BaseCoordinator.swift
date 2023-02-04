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
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Children should implement `start`.")
    }
    
    func show(_ viewController: UIViewController, animated: Bool) {
        // yet to start
    }
    
}
