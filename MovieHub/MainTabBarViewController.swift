//
//  MainTabBarViewController.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var router: HomeCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        router = HomeCoordinator(navigationController: UINavigationController(),tabViewController: self)
        router.start()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
