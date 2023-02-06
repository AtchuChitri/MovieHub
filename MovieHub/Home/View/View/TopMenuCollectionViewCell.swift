//
//  TopMenuCollectionViewCell.swift
//  MovieHub
//
//  Created by Atchu on 7/2/23.
//

import UIKit

class TopMenuCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "TopMenuCollectionViewCell"
    @IBOutlet  weak var title: UILabel!
    @IBOutlet  weak var underline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
