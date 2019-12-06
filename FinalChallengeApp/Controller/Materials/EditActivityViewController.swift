//
//  EditActivityViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class EditActivityViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityName: String = "Abcdefg"
    var howTo: String = "AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg"
    var selectedPrompt: String = ""
    var media: String = "AbcdefgAbcdefgAbcdefg"
    var helpfulTips: String = "AbcdefgAbcdefgAbcdefg"
    var videoLink: String = "AbcdefgAbcdefg"
    
    let promptArray = ["Gesture", "Physical", "Verbal", "Textual/Written", "Visual", "Auditory", "Positional"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension EditActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Activity Name"
        } else if section == 1 {
            return "How to"
        } else if section == 2 {
            return "Prompt"
        } else if section == 3 {
            return "Media (Optional)"
        } else if section == 4 {
            return "Helpful Tips (Optional)"
        } else {
            return "Video Link (Optional)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return promptArray.count
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! EditDefaultTextFieldTableViewCell
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customTextViewCell", for: indexPath) as! EditCustomTextViewTableViewCell
        
        let checkboxCell = tableView.dequeueReusableCell(withIdentifier: "checkboxCell", for: indexPath) as! EditCheckBoxTableViewCell
        
        if indexPath.section == 0 {
            defaultCell.defaultTextField.text = activityName
            return defaultCell
        } else if indexPath.section == 1 {
            customCell.customTextView.text = howTo
            return customCell
        } else if indexPath.section == 2 {
            checkboxCell.promptLabel.text = promptArray[indexPath.row]
            return checkboxCell
        } else if indexPath.section == 3 {
            customCell.customTextView.text = media
            return customCell
        } else if indexPath.section == 4 {
            customCell.customTextView.text = helpfulTips
            return customCell
        } else {
            defaultCell.defaultTextField.text = videoLink
            return defaultCell
        }
    }
}
