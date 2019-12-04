//
//  DetailViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class DetailTherapistReportViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailActivity = [DetailedReportCKModel]()
    var therapySessionRecordID = CKRecord.ID()
    var therapySessionNotes = String()
    var therapySessionDate = Date()
    
    func getActivitySession(){
        print(therapySessionNotes)
        DetailedReportDataManager.getDetailedTherapySession(therapySessionRecordID: therapySessionRecordID) { (activityRecordsID) in
            DetailedReportDataManager.getDetailedActivity(activityRecordID: activityRecordsID) { (DetailActivitiesData) in
                self.detailActivity = DetailActivitiesData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getActivitySession()
        // Do any additional setup after loading the view.
    }
    
    
}


extension DetailTherapistReportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMM yyyy"
            return "Activities on \(formatter.string(from: therapySessionDate))" // diganti date dari Data
        }
        else if section == 1 {
            return "Notes"
        }
        else {
            return "Attachments"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return detailActivity.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section  == 0 {
            return 128
        }
        else if indexPath.section == 1  {
            return 220
        }
        else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var prompts = String()
            detailActivity[indexPath.row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
            cell.activityLabel.text = detailActivity[indexPath.row].activityTitle
            cell.promptLabel.text = "Prompt: " + prompts
            cell.mediaLabel.text = "Media: " + detailActivity[indexPath.row].activityMedia
            
            return  cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as!  NotesTableViewCell
            cell.notesLabel.text = therapySessionNotes
            return  cell
        }
        else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "attachmentsCell", for: indexPath) as! AttachmentsTableViewCell
            
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "showViewDetail") as! ViewDetailViewController
        var prompts = String()
        detailActivity[indexPath.row].activityPrompt .forEach { (prompt) in
            prompts.append("\(prompt), ")
        }
        destination.activity = detailActivity[indexPath.row].activityTitle
        destination.prompt = prompts
        destination.media = detailActivity[indexPath.row].activityMedia
        destination.tips  = detailActivity[indexPath.row].activityTips
        destination.skill = "\(detailActivity[indexPath.row].skillTitle)"
        destination.program = detailActivity[indexPath.row].baseProgramTitle

        performSegue(withIdentifier: "showViewDetail", sender: self)
    }
    
}
