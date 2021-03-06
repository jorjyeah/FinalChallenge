//
//  ActivityTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 21/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    
    var checked : UIImage = UIImage(named: "Checked box")!
    var unchecked : UIImage = UIImage(named: "Unchecked box")!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
       // update UI
        checkBoxImageView.image = selected ? checked : unchecked
//        accessoryType = selected ? .checkmark : .none
    }

}
