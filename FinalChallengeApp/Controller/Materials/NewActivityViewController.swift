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
        
        self.tableView.separatorColor = .clear
        
        // notif for view if keyboard will show or hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMayAdjustView), name: UITextView.textDidChangeNotification, object: nil)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.systemFont(ofSize: 13)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = .gray

        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        headerView.addSubview(myLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        activeTextView = textView
//    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        activeTextView = textView
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeTextView = nil
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
        
        // create done in customTextView
        customCell.customTextView.doneButton(title: "Done", target: self, selector: #selector(dismissKeyboard(sender:)))
        defaultCell.defaultTextField.doneButton(title: "Done", target: self, selector: #selector(dismissKeyboard(sender:)))
        
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
            defaultCell.defaultTextField.delegate = self
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
    
    // keyboard handler for textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("press return to dismiss")
        textField.resignFirstResponder()
        return true
    }

    
    // keyboard handler for textView
    @objc func dismissKeyboard(sender: Any){
        self.view.endEditing(true)
    }
}

extension UITextView{
    // add Done button for textView
    func doneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

extension UITextField{
    func doneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

let height = UIScreen.main.bounds.height
var activeTextField:  UITextField?
var activeTextView: UITextView?

extension UIViewController{
    // configure position UIView for keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        pushView(notification: notification as Notification, view: self.view)
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            self.view.frame.size = CGSize(width: self.view.frame.width, height: view.frame.height - keyboardSize.height)
//        }
    }
    
    func pushView(notification : Notification, view:UIView){
//        guard let userInfo = notification.userInfo else {return}
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
//
//        let keyboardFrame = keyboardSize.cgRectValue
//
//        let kbFrame = self.view.convert(keyboardFrame, to: view.window)
//
//        view.frame.origin.y = -kbFrame.height
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}

        let keyboardFrame = keyboardSize.cgRectValue
        let yPos = height - keyboardFrame.height

        let targetField : CGPoint?
        let activeTextFrameSize : CGFloat?
        if activeTextField != nil {
            targetField = activeTextField?.convert((activeTextField?.frame.origin)!, to: view)
            activeTextFrameSize = (activeTextField?.frame.size.height)!
        } else if activeTextView != nil {
            targetField = activeTextView?.convert((activeTextView?.frame.origin)!, to: view)
            activeTextFrameSize = (activeTextView?.frame.size.height)!
        } else {
            targetField = nil
            activeTextFrameSize = nil
        }

        guard let target = targetField?.y else {return}
        guard let active = activeTextFrameSize else {return}
        let yLastPosition = target + active

        if view.frame.origin.y == 0 && yLastPosition > yPos{
            view.frame.origin.y -= (yLastPosition - yPos + 8)
        }
    }
    
//    @objc func keyboardMayAdjustView(notification: Notification) {
//    var cursor = CGPoint.zero
//    var pointed = CGPoint.zero
//
//        for viewa in self.view.subviews {
//            for viewb in viewa.subviews {
//                if viewb.isKind(of: UITextView .classForCoder()) {
//                    if viewb.isFirstResponder { // got the textView
//                        let tv = viewb as! UITextView
//                        pointed = viewb.convert(viewb.frame.origin, to:self.view)
//                        cursor = tv.caretRect(for: (tv.selectedTextRange?.start)!).origin
//                        break
//                    }
//                }
//            }
//            if (cursor.y > 0.0) {
//                break
//            }
//        }
//
//        var viewNewY : CGFloat = 0.0
//        if self.isKeyboardUp {
//            if (pointed.y + cursor.y > self.keyboardOriginY) { // move the view
//                viewNewY = self.keyboardOriginY - (pointed.y + cursor.y) - 50.0
//            }
//        }
//    }
    // don't move the view up too high
}
