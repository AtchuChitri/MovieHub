//
//  MovieListTableViewCell.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
     static let cellIdentifier = "MovieListTableViewCell"
    @IBOutlet  weak var title: UILabel!
    @IBOutlet  weak var releaseDate: UILabel!
    @IBOutlet  weak var genre: UILabel!
    @IBOutlet  weak var movieImg: UIImageView!
    @IBOutlet  weak var voteCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        applyShadow(cornerRadius: 8)
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImg.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
