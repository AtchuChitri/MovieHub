//
//  SideMenuViewController.swift
//  MovieHub
//
//  Created by Atchu on 3/2/23.
//

import Foundation
import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet var menuTableView: UITableView!
    private var viewModel: SideMenuViewModelContract!
    private let nibNameString: String = "SideMenuViewController"

    var menuItems = [SideMenu(title: "Popular"),
                     SideMenu(title: "Top Rated"),
                     SideMenu(title: "Upcoming"),
                     SideMenu(title: "Now Playing")]

    override func viewDidLoad() {
        self.navigationItem.title = "Menu"
    }
    
    // MARK: - Init
    init(viewModel: SideMenuViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SideMenuViewController: UITableViewDelegate {
    
}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell else { fatalError("xib doesn't exist") }
        menuCell.title.text = viewModel.getValueFromIndexPath(index: indexPath.row)
        return menuCell
    }
}
