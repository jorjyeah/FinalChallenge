//
//  CheckBoxTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxImage: UIImageView!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    var checked : UIImage = UIImage(named: "Checked box")!
    var unchecked : UIImage = UIImage(named: "Unchecked box")!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkboxImage.image = selected ? checked : unchecked
        // Configure the view for the selected state
    }

}
