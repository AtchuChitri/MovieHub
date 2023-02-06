//
//  HomeMenuViewController+CollectionView.swift
//  MovieHub
//
//  Created by Atchu on 7/2/23.
//

import Foundation
import UIKit

extension HomeMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.fetchTopMenuList(HomeMenuTopSections(rawValue: indexPath.row) ?? .nowPlaying, 1)
    }
}

extension HomeMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topMenuSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopMenuCollectionViewCell.cellIdentifier, for: indexPath) as? TopMenuCollectionViewCell else { return UICollectionViewCell() }
        cell.title.text = viewModel.getTopMenuItem(index: indexPath.row)
        if viewModel.getSelectedItem(index: indexPath.row) {
            cell.underline.backgroundColor = .darkGray
            cell.title.font = UIFont.font(withName: .boldFont, size: 12)
        } else {
            cell.title.font = UIFont.font(withName: .regularFont, size: 11)
            cell.underline.backgroundColor = .clear
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}
extension HomeMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 90, height: 40)
    }
}
