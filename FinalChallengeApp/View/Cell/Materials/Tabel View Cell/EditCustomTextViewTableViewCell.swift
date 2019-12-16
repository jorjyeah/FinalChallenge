//
//  EditCustomTextViewTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class EditCustomTextViewTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var customTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.customTextView.delegate = self
        
        customTextView.backgroundColor = .white
        customTextView.layer.cornerRadius = 4
        customTextView.layer.borderWidth = 0.5
        customTextView.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }


}
