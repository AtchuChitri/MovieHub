//
//  HomeMenuViewController+TableDataSource.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import UIKit

extension HomeMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
        cell.releaseDate.text = model.releaseDate
        cell.genre.text = model.originalTitle
        if let imgUrl = model.poster {
            viewModel.fetchImage(url: imgUrl).sink { imgData in
                DispatchQueue.main.async {
                    cell.movieImg.image = UIImage(data: imgData)
                }
            }.store(in: &bag)
        }
        return cell
    }
    
    
}
