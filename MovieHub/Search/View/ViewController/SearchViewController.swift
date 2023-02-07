//
//  SearchViewController.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    // MARK: - Outlets and properties
    var viewModel: SearchViewModelContract!
    var bag = Set<AnyCancellable>()
    private let nibNameString: String = "SearchViewController"
    let searchVC = UISearchController()
    @IBOutlet var searchTblV: UITableView!

    // MARK: - Init
    init(viewModel: SearchViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchVC
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.delegate = self
        setUpTableView()
        dataSetUp()
        // Do any additional setup after loading the view.
    }
    
    func dataSetUp() {
        self.viewModel.reloadList.sink { _ in
        } receiveValue: { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .reload:
                DispatchQueue.main.async {
                    self.searchTblV.reloadData()
                }
            case .startLoader, .stopLoader:
                break
            }
        }.store(in: &bag)
    }

    func setUpTableView() {
        let movieListNib = UINib(nibName: String(describing: MovieListTableViewCell.self),
                                 bundle: Bundle(for: MovieListTableViewCell.self))
        searchTblV.register(movieListNib, forCellReuseIdentifier: MovieListTableViewCell.cellIdentifier)
        searchTblV.rowHeight = UITableView.automaticDimension
        searchTblV.estimatedRowHeight = 110
        searchTblV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchTblV.backgroundColor = .clear
    }

}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard  let searchText = searchController.searchBar.text else { return }
      //  print(searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard  let searchText = searchBar.text else { return }
        viewModel.fetchSearchResults(searchText, 1)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.fetchSearchResults(searchText, 1)
        }
    }
}
