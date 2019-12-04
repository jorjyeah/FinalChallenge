//
//  DefaultTextFieldTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class DefaultTextFieldTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var defaultTitleLabel: UILabel!
    
    @IBOutlet weak var defaultTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
