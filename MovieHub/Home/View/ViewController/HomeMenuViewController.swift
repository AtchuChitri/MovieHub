//
//  HomeMenuViewController.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import UIKit
import Combine
typealias Image = UIImage?
class HomeMenuViewController: UIViewController {

    // MARK: - Outlets and properties
    var viewModel: HomeMenuViewModelContract!
    var bag = Set<AnyCancellable>()
    private let nibNameString: String = "HomeMenuViewController"
    @IBOutlet var homeTblV: UITableView!

    // MARK: - Init
    init(viewModel: HomeMenuViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
        self.setUpTableView()
        self.dataSetUp()
        // Do any additional setup after loading the view.
    }
    
    func dataSetUp() {
        self.viewModel.reloadList.sink { _ in
        } receiveValue: { [weak self] reload in
            guard let self = self else { return }
            if reload {
                self.homeTblV.reloadData()
            }
        }.store(in: &bag)
    }
    
    func setUpNavigation() {
        self.navigationItem.title = "Movie"
    }
    func setUpTableView() {
        let movieListNib = UINib(nibName: String(describing: MovieListTableViewCell.self),
                                 bundle: Bundle(for: MovieListTableViewCell.self))
        homeTblV.register(movieListNib, forCellReuseIdentifier: MovieListTableViewCell.cellIdentifier)
        homeTblV.rowHeight = UITableView.automaticDimension
        homeTblV.estimatedRowHeight = 110
        homeTblV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        homeTblV.backgroundColor = .clear
    }
}
