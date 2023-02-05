//
//  HomeMenuViewController+TableDataSource.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation
import UIKit

extension HomeMenuViewController: UITableViewDelegate {
    
}

extension HomeMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    MovieListTableViewCell.cellIdentifier)!
        return cell
    }
    
    
}
