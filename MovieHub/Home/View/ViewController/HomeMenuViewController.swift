//
//  HomeMenuViewController.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import UIKit

class HomeMenuViewController: UIViewController {

    // MARK: - Outlets and properties
    private var viewModel: HomeMenuViewModelContract!
    private let nibNameString: String = "HomeMenuViewController"
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        let menuCellNib = UINib(nibName: String(describing: MovieListTableViewCell.self),
                                bundle: Bundle(for: MovieListTableViewCell.self))
        tableView.register(menuCellNib, forCellReuseIdentifier: MovieListTableViewCell.cellIdentifier)
        tableView.allowsSelection = true
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Init
    init(viewModel: HomeMenuViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func loadView() {
        self.view = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigation() {
        self.navigationItem.title = "Movie"
    }
}
