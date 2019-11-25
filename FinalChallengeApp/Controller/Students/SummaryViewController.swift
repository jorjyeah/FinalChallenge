//
//  SummaryViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 22/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedActivity = [String]()
    
    let promptArray = ["Gesture, Physical, Verbal", "Gesture, Physical, Verbal", "Gesture, Physical, Verbal", "Gesture, Physical, Verbal"]
    let mediaArray = ["", "Mirror, Doll", "Mirror, Doll", "Mirror, Doll"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showReportView() {
      if let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportViewController") as? ReportViewController {
        self.present(mvc, animated: true, completion: nil)
      }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Submit Note to Parents?", message: "", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (UIAlertAction)in
            self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    

}


extension SummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Activities on Friday, 18 Oct 2019"
        }
        else {
            return "Notes"
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
        }
        else {
            return 220
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailSummaryTableViewCell
            cell.activityLabel.text = selectedActivity[indexPath.row]
            cell.promptLabel.text = "Prompt: " + promptArray[indexPath.row]
            cell.mediaLabel.text = "Media: " + mediaArray[indexPath.row]
            
            return  cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as!  NotesSummaryTableViewCell
            
            return  cell
        }
        
    }
  
}
