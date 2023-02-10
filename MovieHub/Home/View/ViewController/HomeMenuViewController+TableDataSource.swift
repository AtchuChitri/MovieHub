//
//  HomeMenuViewController+TableDataSource.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import UIKit
import Combine

extension HomeMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.getIndexValue(index: indexPath.section)
        self.viewModel.movieSelected.send(.movieDetail(model.id))
    }
}

extension HomeMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        MovieListTableViewCell.cellIdentifier) as? MovieListTableViewCell else {
           return UITableViewCell()
       }
        let model = viewModel.getIndexValue(index: indexPath.section)
        cell.title.text = model.title
        cell.releaseDate.text = model.releaseDate?.getDateString()
        cell.genre.text = model.originalTitle
        if let imgUrl = model.poster {
            viewModel.fetchImage(url: imgUrl).sink { imgData in
                DispatchQueue.main.async {
                    cell.movieImg.image = UIImage(data: imgData)
                }
            }.store(in: &bag)
        }
        if let genreList = model.genreIds, let genre = viewModel.getGenre(genreList) {
            cell.genre.text = genre
        } 
        if (indexPath.section == viewModel.dataSource.count - 1) && viewModel.checkReloadList() {
            viewModel.fetchTopMenuList(viewModel.selectedMenu, viewModel.page+1)
        }
        if let vote = model.voteCount, let average = model.voteAverage {
            cell.voteCount.text = "Vote Count: \(vote), Average:\(average)"
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}
