//
//  MovieListTableViewCell.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
     static let cellIdentifier = "MovieListTableViewCell"
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet private weak var movieImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
