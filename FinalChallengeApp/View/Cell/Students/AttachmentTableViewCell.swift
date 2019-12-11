//
//  AttachmentTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 09/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAttachment: UIImageView!
    
    @IBOutlet weak var audioAttachment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
