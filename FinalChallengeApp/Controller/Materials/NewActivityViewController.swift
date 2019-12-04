//
//  NewActivityViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController {
    
    var activityName: String = ""
    var howTo: String = ""
    var selectedPrompt: String = ""
    var media: String = ""
    var helpfulTips: String = ""
    var videoLink: String = ""
    
    let promptArray = ["Gesture", "Physical", "Verbal", "Textual/Written", "Visual", "Auditory", "Positional"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension NewActivityViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! DefaultTextFieldTableViewCell
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customTextFieldCell", for: indexPath) as! CustomTextFieldTableViewCell
        
        let checkboxCell = tableView.dequeueReusableCell(withIdentifier: "checkboxCell", for: indexPath) as! CheckBoxTableViewCell
        
        if indexPath.section == 0 {
            defaultCell.defaultTextField.text = activityName
            return defaultCell
        } else if indexPath.section == 1 {
            customCell.customTextField.text = howTo
            return customCell
        } else if indexPath.section == 2 {
            checkboxCell.promptLabel.text = promptArray[indexPath.row]
            return checkboxCell
        } else if indexPath.section == 3 {
            customCell.customTextField.text = media
            return customCell
        } else if indexPath.section == 4 {
            customCell.customTextField.text = helpfulTips
            return customCell
        } else {
            defaultCell.defaultTextField.text = videoLink
            return defaultCell
        }
    }
    
}
