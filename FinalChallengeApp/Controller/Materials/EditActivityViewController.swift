//
//  EditActivityViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class EditActivityViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var skillRecordID = CKRecord.ID()
    var activityName: String = ""
    var desc: String = ""
    var selectedPrompts = [String]()
    var previousPrompts = [String]()
    var media: String = ""
    var helpfulTips: String = ""
    var videoLink: String = ""
    
    let promptArray = ["Gesture", "Physical", "Verbal", "Textual/Written", "Visual", "Auditory", "Positional"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }

}


extension EditActivityViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
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
            defaultCell.defaultTextField.delegate = self
            defaultCell.defaultTextField.text = activityName
            defaultCell.defaultTextField.tag = indexPath.section
            return defaultCell
        } else if indexPath.section == 1 {
            customCell.customTextView.delegate = self
            customCell.customTextView.text = desc
            customCell.customTextView.tag = indexPath.section
            return customCell
        } else if indexPath.section == 2 {
            checkboxCell.promptLabel.text = promptArray[indexPath.row]
            checkboxCell.setSelected(true, animated: true)
            return checkboxCell
        } else if indexPath.section == 3 {
            customCell.customTextView.delegate = self
            customCell.customTextView.text = media
            customCell.customTextView.tag = indexPath.section
            return customCell
        } else if indexPath.section == 4 {
            customCell.customTextView.delegate = self
            customCell.customTextView.text = helpfulTips
            customCell.customTextView.tag = indexPath.section
            return customCell
        } else {
            defaultCell.defaultTextField.text = videoLink
            return defaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 2 {
            return indexPath
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPrompts.append(promptArray[indexPath.row])
        print(selectedPrompts)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedPrompts = selectedPrompts.filter{$0 != promptArray[indexPath.row]}
        print(selectedPrompts)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView.tag {
        case 1 :
            self.desc = textView.text!
            print(desc)
        case 3 :
            self.media = textView.text!
            print(media)
        case 4 :
            self.helpfulTips = textView.text!
            print(helpfulTips)
        default:
            print("nothing")
        }
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0 :
            self.activityName = textField.text!
            print(activityName)
        default:
            print("nothing")
        }
    }
}
