//
//  BaseCoordinatorContract.swift
//  MovieHub
//
//  Created by Atchu on 3/2/23.
//

import Foundation
import UIKit

public protocol BaseCoordinatorContract: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: BaseCoordinatorContract? { get }

    /// Children should implement `start Router with initial Screen
    func start()
    /// Navigation Actions
    func show(_ viewController: UIViewController, animated: Bool)
}

protocol CoordinatorDelegate: AnyObject {
    func setDelegate(_ delegate: BaseCoordinatorContract)
}
