//
//  GenreTableViewCell.swift
//  MovieHub
//
//  Created by Atchu on 9/2/23.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet  weak var adultLbl: UILabel!
    @IBOutlet  weak var releaseLbl: UILabel!
    @IBOutlet  weak var genreLbl: UILabel!
    static let cellIdentifier = "GenreTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
