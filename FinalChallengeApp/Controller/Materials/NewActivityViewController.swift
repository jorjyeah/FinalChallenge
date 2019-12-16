//
//  NewActivityViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class NewActivityViewController: UIViewController {
    
    var skillRecordID = CKRecord.ID()
    var activityName: String = ""
    var desc: String = ""
    var media: String = ""
    var helpfulTips: String = ""
    var videoLink: String = ""
    var selectedPrompts = [String]()
    
    let promptArray = ["Gesture", "Physical", "Verbal", "Textual/Written", "Visual", "Auditory", "Positional"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        
        self.HideKeyboard()// keyboard handler
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? ActivityViewController,
            let record = sender as? CKRecord
        else {
            return
        }
        
        destination.activities.append(ActivityCKModel(record: record))
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Can't create new activity", message: "Please complete all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if activityName == "" || desc == "" || media == "" || helpfulTips == "" || selectedPrompts.count == 0{
            print("harus ada data")
            self.present(alert, animated: true)
            // bikin alert "Semua field harus diisi"
        } else {
            print("ada data")
            ActivityDataManager.addNewActivity(skillRecordID: skillRecordID, activityName: activityName, activityDesc: desc, activityMedia: media, activityTips: helpfulTips, activityPrompts: selectedPrompts) { (record) in
                
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "backToActivityFromAddNewActivity", sender: record)
                    }
            }
        }
    }
    
    
    
}

extension NewActivityViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
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
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customTextViewCell", for: indexPath) as! CustomTextViewTableViewCell
        
        let checkboxCell = tableView.dequeueReusableCell(withIdentifier: "checkboxCell", for: indexPath) as! CheckBoxTableViewCell
        
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
    
    // keyboard handler
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("press return to dismiss")
        textField.resignFirstResponder()
        return true
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func HideKeyboard(){
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
}
