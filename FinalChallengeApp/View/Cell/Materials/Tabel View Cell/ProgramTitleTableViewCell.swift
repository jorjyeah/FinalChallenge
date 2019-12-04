//
//  ProgramTitleTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 24/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ProgramTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var programTitleLabel: UILabel!
    
    @IBOutlet weak var programTitleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        programTitleImage.layer.cornerRadius = 8
        programTitleImage.layer.shadowOffset = CGSize(width: 2, height: 2)
        programTitleImage.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        programTitleImage.layer.shadowOpacity = 1
        programTitleImage.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
