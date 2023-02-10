//
//  MovieDetailViewController.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import UIKit
import Combine

class MovieDetailViewController: UIViewController {
    
    // MARK: - Outlets and properties
    var viewModel: MovieDetailViewModelContract!
    var bag = Set<AnyCancellable>()
    private let nibNameString: String = "MovieDetailViewController"
    @IBOutlet var detailTblV: UITableView!
    
    
    
    // MARK: - Init
    init(viewModel: MovieDetailViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTableView()
        viewModel.fetchMovieDetails()
        self.dataSetUp()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
       
        let rightBarBtn = UIBarButtonItem(image: UIImage(named: viewModel.isFavioute ? "favoriteF": "favorites"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.makeFavourite))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        rightBarBtn.tintColor = .white


        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back"),
                                            style: UIBarButtonItem.Style.plain, target: self,
                                            action: #selector(self.backButtonAction))
        leftBarButton.isAccessibilityElement = true
        leftBarButton.tintColor = .white

       // leftBarButton.tintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.tabBarController?.tabBar.isHidden = true
        

    }
    @objc
    func backButtonAction() {
        self.viewModel.eventCallBack.send(.back)
    }
    @objc
    func makeFavourite() {
        self.viewModel.makeFavourite()
    }
    
    func setUpTableView() {
        let movieListNib = UINib(nibName: String(describing: BannerTableViewCell.self),
                                 bundle: Bundle(for: BannerTableViewCell.self))
        detailTblV.register(movieListNib, forCellReuseIdentifier: BannerTableViewCell.cellIdentifier)
        
        let genreNib = UINib(nibName: String(describing: GenreTableViewCell.self),
                             bundle: Bundle(for: GenreTableViewCell.self))
        detailTblV.register(genreNib, forCellReuseIdentifier: GenreTableViewCell.cellIdentifier)
        
        let overViewNib = UINib(nibName: String(describing: OverviewTableViewCell.self),
                                bundle: Bundle(for: OverviewTableViewCell.self))
        detailTblV.register(overViewNib, forCellReuseIdentifier: OverviewTableViewCell.cellIdentifier)
        
        let statusViewNib = UINib(nibName: String(describing: StatusTableViewCell.self),
                                bundle: Bundle(for: StatusTableViewCell.self))
        detailTblV.register(statusViewNib, forCellReuseIdentifier: StatusTableViewCell.cellIdentifier)
        
        detailTblV.rowHeight = UITableView.automaticDimension
        detailTblV.estimatedRowHeight = 110
        detailTblV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        detailTblV.backgroundColor = .clear
        self.detailTblV.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0);
    }
    
    func dataSetUp() {
        self.viewModel.eventAction.sink { _ in
        } receiveValue: { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .reload:
                DispatchQueue.main.async {
                    self.detailTblV.reloadData()
                    self.setUpNavigation()
                }
            case .startLoader, .stopLoader:
                break
            case .deletedRecord,.saveRecord:
                DispatchQueue.main.async {
                    self.setUpNavigation()
                }
            }
        }.store(in: &bag)
    }
}
