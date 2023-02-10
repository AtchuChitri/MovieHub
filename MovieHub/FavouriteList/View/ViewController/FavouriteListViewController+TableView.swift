//
//  FavouriteListViewController+TableView.swift
//  MovieHub
//
//  Created by Atchu on 10/2/23.
//

import Foundation
import UIKit

extension FavouriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.getIndexValue(index: indexPath.section)
        self.viewModel.movieSelected.send(.movieDetail(Int(model.id)))
    }
}
extension FavouriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                         MovieListTableViewCell.cellIdentifier) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        let model = self.viewModel.getIndexValue(index: indexPath.section)
        cell.title.text = model.title
        cell.releaseDate.text = viewModel.getReleaseDate(model.releaseDate)
        cell.voteCount.text = "Vote Count: \(model.voteCount), Average:\(model.voteAverage)"
        if let imgUrl = model.posterPath {
            viewModel.fetchImage(url: imgUrl).sink { imgData in
                DispatchQueue.main.async {
                    cell.movieImg.image = UIImage(data: imgData)
                }
            }.store(in: &bag)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
}
