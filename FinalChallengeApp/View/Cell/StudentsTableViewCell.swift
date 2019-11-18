//
//  StudentsTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 15/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StudentsTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var studentSchedule: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
