//
//  CustomTextFieldTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class CustomTextViewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var customTextView: UITextView!
    var textValue: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        customTextView.delegate = self as! UITextViewDelegate
        
        customTextView.backgroundColor = .white
        customTextView.layer.cornerRadius = 4
        customTextView.layer.borderWidth = 0.5
        customTextView.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
