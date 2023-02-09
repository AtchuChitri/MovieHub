//
//  OverviewTableViewCell.swift
//  MovieHub
//
//  Created by Atchu on 9/2/23.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet  weak var tagLineLbl: UILabel!
    @IBOutlet  weak var overviewLbl: UILabel!
    static let cellIdentifier = "OverviewTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
