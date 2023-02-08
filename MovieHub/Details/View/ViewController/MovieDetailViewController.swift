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

    @IBOutlet  weak var backDropImg: UIImageView!
    @IBOutlet  weak var posterImg: UIImageView!
    @IBOutlet  weak var movieTitle: UILabel!
    @IBOutlet  weak var releaseDate: UILabel!
    @IBOutlet  weak var duration: UILabel!
    @IBOutlet  weak var genre: UILabel!


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
    }
    @objc
    func backButtonAction() {
        self.viewModel.eventCallBack.send(.back)
    }
    
    func dataSetUp() {
        self.viewModel.eventAction.sink { _ in
        } receiveValue: { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .reload:
                DispatchQueue.main.async {
                    self.loadBackDropImage()
                    self.loadPosterImage()
                    self.movieTitle.text = self.viewModel.dataSource?.title
                    self.releaseDate.text = self.viewModel.dataSource?.releaseDate
                    self.duration.text = "\(self.viewModel.dataSource?.runtime)"
                    self.genre.text = self.viewModel.fetchGenre()
                }
            case .startLoader, .stopLoader:
                break
            }
        }.store(in: &bag)
    }
    
    func loadBackDropImage() {
        if let backDropPath = self.viewModel.dataSource?.backdropPath {
            self.viewModel.fetchImage(url: backDropPath).sink { imgData in
                DispatchQueue.main.async {
                    self.backDropImg.image = UIImage(data: imgData)
                }
            }.store(in: &self.bag)

        }
    }
    
    func loadPosterImage() {
        if let poster = self.viewModel.dataSource?.posterPath {
            self.viewModel.fetchImage(url: poster).sink { imgData in
                DispatchQueue.main.async {
                    self.posterImg.image = UIImage(data: imgData)
                }
            }.store(in: &self.bag)

        }
    }

}
