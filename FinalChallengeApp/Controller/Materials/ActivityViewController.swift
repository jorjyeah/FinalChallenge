//
//  ActivityViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 24/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindFromAddNewActivity(_ segue:UIStoryboardSegue){
        // bikin function dulu buat unwind, nanti di exit di page summary
        if segue.source is NewActivityViewController{
            tableView.reloadData()
        }
    }
    
    
    var skillRecordID = CKRecord.ID()
    var skillTitle = String()
    var baseProgram = String()
    var activities = [ActivityCKModel]()
    let activityTaskArray = ["Play Doh", "Stomp Feet", "Point to Body Parts"]
    
    override func viewWillAppear(_ animated: Bool) {
        populateData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        populateData()
        // Do any additional setup after loading the view.
        
        
    }
    
    func populateData(){
        ActivityDataManager.getAllActivity(skillRecordID: skillRecordID) { (activityModel) in
            self.activities = activityModel
            self.activities .forEach { (activity) in
                activity.skillTitle = self.skillTitle
                activity.baseProgram = self.baseProgram
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

}



extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return activities.count
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section  == 0 {
            return 218
        }
        else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "programTitleCell", for: indexPath) as! ProgramTitleTableViewCell
            cell.programTitleLabel.text = "\(skillTitle)"
            
            return  cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityTaskCell", for: indexPath) as! ActivityTaskTableViewCell
            cell.activityTaskLabel.text = activities[indexPath.row].activityTitle
        
            return  cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewCell", for: indexPath) as! AddActivityTableViewCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showDeletePage", sender: self)
        } else if indexPath.section == 1 {
            performSegue(withIdentifier: "showActivityDetail", sender: indexPath.row)
        } else if indexPath.section == 2{
            performSegue(withIdentifier: "showAddActivity", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        print(activities.count)
        if section == 1 && activities.count == 0{
            let footer = UIView()
            let emptyStateImage = UIImageView()
            emptyStateImage.image = UIImage(named: "Search not found")
            emptyStateImage.frame = CGRect(x: 0, y: 0, width: 296, height: 284)
            footer.addSubview(emptyStateImage)
            return footer
        } else {
            let footer = UIView()
            return footer
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivityDetail" {
            let row = sender as! Int
            let destination = segue.destination as! ActivityDetailViewController
            destination.activityTitle = activities[row].activityTitle
            destination.activityDesc = activities[row].activityDesc
            destination.activityRecordID = activities[row].activityRecordID
            destination.activityMedia = activities[row].activityMedia
            destination.activityPrompts = activities[row].activityPrompt
            destination.activityTips = activities[row].activityTips
            destination.skillRecordID = skillRecordID
            destination.activitySkill = skillTitle
            destination.activityProgram = baseProgram
        } else if segue.identifier == "showAddActivity" {
            let destination = segue.destination as! NewActivityViewController
            destination.skillRecordID = skillRecordID
        }
    }
    
}
