//
//  FavouriteListViewController.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import UIKit
import Combine

class FavouriteListViewController: UIViewController {
    @IBOutlet var favouriteTblV: UITableView!
    var viewModel: FavouriteListViewModelContract!
    private let nibNameString: String = "FavouriteListViewController"
    var bag = Set<AnyCancellable>()

    // MARK: - Init
    init(viewModel: FavouriteListViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNavigation()
        dataSetUp()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFavouriteList()
        self.tabBarController?.tabBar.isHidden = false
    }

    func setUpTableView() {
        let movieListNib = UINib(nibName: String(describing: MovieListTableViewCell.self),
                                 bundle: Bundle(for: MovieListTableViewCell.self))
        favouriteTblV.register(movieListNib, forCellReuseIdentifier: MovieListTableViewCell.cellIdentifier)
        favouriteTblV.rowHeight = UITableView.automaticDimension
        favouriteTblV.estimatedRowHeight = 110
        favouriteTblV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        favouriteTblV.backgroundColor = .clear
    }
    func setUpNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func dataSetUp() {
        self.viewModel.reloadList.sink { _ in
        } receiveValue: { [weak self] event in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.favouriteTblV.reloadData()
            }
        }.store(in: &bag)
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
