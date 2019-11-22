//
//  AddReportViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class AddReportViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //let checkedImage = UIImage(named: "CheckBoxChecked")! as UIImage
    //let uncheckedImage = UIImage(named: "CheckBoxUnChecked")! as UIImage
    
    var activityArray = ["Stomp feet", "Point to  body parts", "Extend index finger",  "Place thumbs up"]
    
    var selectedActivity = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummary" {
            let destination = segue.destination as! SummaryViewController
            
            destination.selectedActivity = selectedActivity
        }
    }
    
}

extension AddReportViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as!  ActivityTableViewCell
        
        cell.activityNameLabel.text = activityArray[indexPath.row]
        cell.selectionStyle = .none
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkboxTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func checkboxTapped(sender: UIButton) {
        let selectLabel = activityArray[sender.tag]
        if sender.isSelected {
            //uncheck the butoon
            sender.isSelected = false
            selectedActivity = selectedActivity.filter{$0 != selectLabel}
        } else {
            // checkmark it
            sender.isSelected = true
            selectedActivity.append(selectLabel)
        }
        print(selectedActivity)
    }
    
}
