//
//  SummaryViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 22/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class SummaryViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBOutlet weak var attachmentView: UIView!
    
    let saveReport = SaveNewReport()
    var selectedActivity = [AddReportModelCK]()
    var studentRecordID = String()
    let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
    var notes = String()
    var test : String!
    
    
    var imagePicker = UIImagePickerController()
    var audioFilename = URL(string: "")
    
    //yang selected ditampung kesini
    var selectedImage = UIImage(named: "Student Photo Default")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachmentView.isHidden = true
    }
    
    
    //ini handlernya image attachment
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("tinggal masuk ke gallery")
        _ = tapGestureRecognizer.view as! UIImageView
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
        print("udah masuk ke gallery")
    }
    
    
    
    //ini handlernya audio attachment
    @objc func recordTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        _ = tapGestureRecognizer.view as! UIImageView
        self.performSegue(withIdentifier: "showRecordView", sender: self)
    }
    
    func showReportView() {
        if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportViewController") as? ReportViewController {
            self.present(mvc, animated: true, completion: nil)
        }
    }
    
    func saveTherapySession(){
        saveReport.saveReport(childName: studentRecordID, therapistName: therapistRecordID, therapySessionNotes: notes) { (therapySessionRecordID) in
            self.selectedActivity .forEach { (detailedActivity) in
                print(detailedActivity.activityRecordID)
                self.saveReport.saveActivitySessions(activityReference: detailedActivity.activityRecordID, childName: self.studentRecordID, therapySession: therapySessionRecordID) { (success) in
                    print("\(success) saved")
                }
            }
        }
    }
}


extension SummaryViewController: UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Write your notes about today's activity"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMM yyyy"
            return "Activities on \(formatter.string(from: Date()))"
        }
        else if section == 1{
            return "Notes"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return selectedActivity.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section  == 0 {
            return 128
        } else if indexPath.section == 1 {
            return 220
        } else {
            return 55
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var prompts = String()
            selectedActivity[indexPath.row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailSummaryTableViewCell
            cell.activityLabel.text = selectedActivity[indexPath.row].activityTitle
            cell.promptLabel.text = "Prompt: " + prompts
            cell.mediaLabel.text = "Media: " + selectedActivity[indexPath.row].activityMedia
            
            return  cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as!  NotesSummaryTableViewCell
            cell.notesTextView.text = "Write your notes about today's activity"
            cell.notesTextView.textColor = UIColor.lightGray
            cell.notesTextView.becomeFirstResponder()
            cell.notesTextView.selectedTextRange = cell.notesTextView.textRange(from: cell.notesTextView.beginningOfDocument, to: cell.notesTextView.beginningOfDocument)
            return  cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "attachmentCell", for: indexPath) as! AttachmentTableViewCell
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            let audioTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(recordTapped(tapGestureRecognizer:)))
            
            //ini untuk action image
            cell.imageAttachment.isUserInteractionEnabled = true
            cell.imageAttachment.addGestureRecognizer(tapGestureRecognizer)
            
            //ini untuk action audio
            cell.audioAttachment.isUserInteractionEnabled = true
            cell.audioAttachment.addGestureRecognizer(audioTapRecognizer)

            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showSummaryViewDetail", sender: indexPath.row)
        } else if indexPath.section == 2 {
            //sementara kalo tap attachment cell nya bakal muncul view
            attachmentView.isHidden = false
        } else {
            print("Ini textview nya")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummaryViewDetail" {
            let destination = segue.destination as? ViewDetailSummaryViewController
            let row = sender as! Int
            var prompts = String()
            selectedActivity[row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            print("masuk summary")
            destination?.activity = selectedActivity[row].activityTitle
            destination?.howTo = selectedActivity[row].activityDesc
            destination?.prompt = prompts
            print(prompts)
            destination?.media = selectedActivity[row].activityMedia
            destination?.tips  = selectedActivity[row].activityTips
            destination?.skill = selectedActivity[row].skillTitle.recordID
            destination?.program = CKRecord.ID(recordName: selectedActivity[row].baseProgramTitle)
        } else {
            test = "coba balik"
            saveTherapySession()
        }
    }
}

extension SummaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageView.image = image
        }
        print("udah pilih image nih")
        dismiss(animated: true, completion: nil)
        attachmentView.isHidden = false
    }
    
}
