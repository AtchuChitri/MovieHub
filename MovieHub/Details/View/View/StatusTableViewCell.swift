//
//  StatusTableViewCell.swift
//  MovieHub
//
//  Created by Atchu on 9/2/23.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet  weak var statusLbl: UILabel!
    @IBOutlet  weak var orginalLangLbl: UILabel!
    @IBOutlet  weak var budgetLbl: UILabel!
    @IBOutlet  weak var revenueLbl: UILabel!

    static let cellIdentifier = "StatusTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
