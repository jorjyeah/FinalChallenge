//
//  EditCheckBoxTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class EditCheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxImageView: UIImageView!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
