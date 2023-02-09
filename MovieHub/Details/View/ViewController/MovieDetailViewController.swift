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
        let iconButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        iconButton.setImage(UIImage(named: "back"), for: .normal)
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back"),
                                            style: UIBarButtonItem.Style.plain, target: self,
                                            action: #selector(self.backButtonAction))
        leftBarButton.isAccessibilityElement = true
        leftBarButton.tintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc
    func backButtonAction() {
        self.viewModel.eventCallBack.send(.back)
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
        
        detailTblV.rowHeight = UITableView.automaticDimension
        detailTblV.estimatedRowHeight = 110
        detailTblV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        detailTblV.backgroundColor = .clear
        self.detailTblV.estimatedSectionFooterHeight = 16.0 // spacing between Sections
    }
    
    func dataSetUp() {
        self.viewModel.eventAction.sink { _ in
        } receiveValue: { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .reload:
                DispatchQueue.main.async {
                    self.detailTblV.reloadData()
                }
            case .startLoader, .stopLoader:
                break
            }
        }.store(in: &bag)
    }
}
