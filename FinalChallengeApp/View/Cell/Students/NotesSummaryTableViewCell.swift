//
//  NotesSummaryTableViewCell.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 21/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class NotesSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notesTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notesTextView.backgroundColor = .white
        notesTextView.layer.cornerRadius = 4
        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
