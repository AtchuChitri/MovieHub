//
//  BannerTableViewCell.swift
//  MovieHub
//
//  Created by Atchu on 9/2/23.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    @IBOutlet  weak var backDropImg: UIImageView!
    @IBOutlet  weak var posterImg: UIImageView!
    @IBOutlet  weak var movieTitle: UILabel!
    static let cellIdentifier = "BannerTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
