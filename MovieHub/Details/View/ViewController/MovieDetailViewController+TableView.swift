//
//  MovieDetailViewController+TableView.swift
//  MovieHub
//
//  Created by Atchu on 9/2/23.
//

import Foundation
import UIKit

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailSections = DetailSections(rawValue: indexPath.section)
        switch detailSections {
        case .bannerView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            BannerTableViewCell.cellIdentifier) as? BannerTableViewCell else {
                return UITableViewCell()
            }
            cell.movieTitle.text = self.viewModel.dataSource?.title
            if let backDropPath = self.viewModel.dataSource?.backdropPath {
                self.viewModel.fetchImage(url: backDropPath).sink { imgData in
                    DispatchQueue.main.async {
                        cell.backDropImg.image = UIImage(data: imgData)
                    }
                }.store(in: &self.bag)
                
            }
            
            if let poster = self.viewModel.dataSource?.posterPath {
                self.viewModel.fetchImage(url: poster).sink { imgData in
                    DispatchQueue.main.async {
                        cell.posterImg.image = UIImage(data: imgData)
                    }
                }.store(in: &self.bag)
                
            }
            
            
            return cell
        case .genreView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            GenreTableViewCell.cellIdentifier) as? GenreTableViewCell else {
                return UITableViewCell()
            }
            cell.genreLbl.text = viewModel.fetchGenre()
            if let date = viewModel.getReleaseDate(), let runtime = viewModel.getRunTime() {
                cell.releaseLbl.text = "Release: \(date) . \(runtime)"
            }
            cell.adultLbl.text = viewModel.getAdult()
            return cell
        case .overview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            OverviewTableViewCell.cellIdentifier) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            
            cell.tagLineLbl.text = viewModel.dataSource?.tagline
            cell.overviewLbl.text = viewModel.dataSource?.overview
            return cell
        case .statusView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            StatusTableViewCell.cellIdentifier) as? StatusTableViewCell else {
                return UITableViewCell()
            }
            
            cell.statusLbl.text = viewModel.dataSource?.status
            cell.budgetLbl.text = "\(viewModel.dataSource?.budget ?? 0)"
            cell.revenueLbl.text = "\(viewModel.dataSource?.revenue ?? 0)"
            cell.orginalLangLbl.text = viewModel.getSpokenLanguage()
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    
}
extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let detailSections = DetailSections(rawValue: indexPath.section)
        switch detailSections {
        case .bannerView:
            return 180
        case .genreView:
            return 65
        case .overview:
            return UITableView.automaticDimension
        case .statusView:
            return 205
        case .none:
            return UITableView.automaticDimension
        }

    }
}
