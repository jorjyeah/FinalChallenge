//
//  DetailSummaryTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 21/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class DetailSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var mediaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
