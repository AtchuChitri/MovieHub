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
    @IBOutlet var topMenuCV: UICollectionView!

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
        self.setUpCollectionView()
        self.setUpTableView()
        self.dataSetUp()
        self.viewModel.fetchGenreList()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func dataSetUp() {
        self.viewModel.reloadList.sink { _ in
        } receiveValue: { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .reload:
                DispatchQueue.main.async {
                    self.homeTblV.reloadData()
                    self.topMenuCV.reloadData()
                }
            case .startLoader, .stopLoader:
                break
            }
        }.store(in: &bag)
    }
    
    func setUpNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpCollectionView() {
        let topMenuCellNib = UINib(nibName: String(describing: TopMenuCollectionViewCell.self),
                                 bundle: Bundle(for: TopMenuCollectionViewCell.self))
        topMenuCV.register(topMenuCellNib, forCellWithReuseIdentifier: TopMenuCollectionViewCell.cellIdentifier)
        DispatchQueue.main.async {
            self.topMenuCV.reloadData()
        }
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
