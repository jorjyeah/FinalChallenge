//
//  ActivityDetailViewController.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 09/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ActivityDetailViewController: UIViewController {

    var activityRecordID = CKRecord.ID()
    var skillRecordID = CKRecord.ID()
    var activityTitle = String()
    var activityDesc = String()
    var activityPrompts = [String]()
    var activityTips = String()
    var activityMedia = String()
    var activitySkill = String()
    var activityProgram = String()
    
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var activityDescLabel: UILabel!
    @IBOutlet weak var activityPromptsLabel: UILabel!
    @IBOutlet weak var activityMediaLabel: UILabel!
    @IBOutlet weak var activityTipsLabel: UILabel!
    @IBOutlet weak var activitySkillLabel: UILabel!
    @IBOutlet weak var activityProgramLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditActivity" {
            let destination = segue.destination as! EditActivityViewController
            destination.skillRecordID = skillRecordID
            destination.activityName = activityTitle
            destination.previousPrompts = activityPrompts
            destination.desc = activityDesc
            destination.helpfulTips = activityTips
            destination.media = activityMedia
            
        }
    }
    
    func populateData(){
        DispatchQueue.main.async {
            var prompts = ""
            self.activityPrompts .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            self.activityTitleLabel.text = self.activityTitle
            self.activityDescLabel.text = self.activityDesc
            self.activityPromptsLabel.text = prompts
            self.activityMediaLabel.text = self.activityMedia
            self.activityTipsLabel.text = self.activityTips
            self.activitySkillLabel.text = self.activitySkill
            self.activityProgramLabel.text = self.activityProgram
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
