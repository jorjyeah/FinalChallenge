//
//  ParentsDetailViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 25/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ParentsDetailViewController: UIViewController {
    
    var parentNote = String()
    var parentNoteDate = Date()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        notesLabel.frame = CGRect(x: 16, y: 137, width: 382, height: 104)
        notesLabel.backgroundColor = .white
        notesLabel.layer.cornerRadius = 4
        notesLabel.layer.borderWidth = 0.3
        notesLabel.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy, HH:mm a"
        
        dateLabel.text = formatter.string(from: parentNoteDate)
        notesLabel.text = parentNote
    }

    

}
