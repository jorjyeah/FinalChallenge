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
    
    var checked : UIImage = UIImage(named: "Checked box")!
    var unchecked : UIImage = UIImage(named: "Unchecked box")!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkboxImageView.image = selected ? checked : unchecked
        // Configure the view for the selected state
    }

}
