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
    
//    let activityArray = ["Stomp feet", "Point to  body parts", "Extend index finger",  "Place thumbs up"]
    
    var sections = ["Last Activities","All Activities"]
    var selectedActivityTitle = [String]()
    var selectedActivityRecordID = [String]()
    var selected = [AddReportModelCK]()
    var allActivitiesList = [AddReportModelCK]()
    var lastActivitiesList =  [AddReportModelCK]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
        
        let allActivityData = AddReportModelCK.self
        allActivityData.getActivity { allActivitiesData in
            self.allActivitiesList = allActivitiesData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let lastActivityData = AddReportModelCK.self
        lastActivityData.getLastActivity { lastActivitiesData in
            if lastActivitiesData.count != 0 {
                lastActivityData.getActivityBasedOnLastActivities(activitiesRecordID: lastActivitiesData) { activities in
                    self.lastActivitiesList = activities
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } else {
                self.lastActivitiesList[0].activityTitle = "No Last Activity"
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummary" {
            let destination = segue.destination as! SummaryViewController
//            destination.selectedActivityTitle = selectedActivityTitle
//            destination.selectedActivityRecordID = selectedActivityRecordID
            destination.selectedActivity = selected
        }
    }
}

extension AddReportViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return lastActivitiesList.count
        } else  if section == 1 {
            return allActivitiesList.count
        } else  {
            return 0
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            lastActivitiesList[indexPath.row].isSelected = true
            selectedActivityTitle.append(lastActivitiesList[indexPath.row].activityTitle)
            selectedActivityRecordID.append(lastActivitiesList[indexPath.row].activityRecordID)
            selected.append(lastActivitiesList[indexPath.row])
            
        } else if indexPath.section == 1 {
            allActivitiesList[indexPath.row].isSelected = true
            selectedActivityTitle.append(allActivitiesList[indexPath.row].activityTitle)
            selectedActivityRecordID.append(allActivitiesList[indexPath.row].activityRecordID)
            selected.append(allActivitiesList[indexPath.row])
        }
        
        if let sr = tableView.indexPathsForSelectedRows {
            print("didDeselectRowAtIndexPath selected rows:\(sr)")
        }
        
        print(selectedActivityTitle)
        print(selectedActivityRecordID)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            lastActivitiesList[indexPath.row].isSelected = false
            selectedActivityTitle = selectedActivityTitle.filter{$0 != lastActivitiesList[indexPath.row].activityTitle}
            selectedActivityRecordID = selectedActivityRecordID.filter{$0 != lastActivitiesList[indexPath.row].activityRecordID}
            selected = selected.filter{$0 != lastActivitiesList[indexPath.row]}
        } else if indexPath.section == 1 {
            allActivitiesList[indexPath.row].isSelected = false
            selectedActivityTitle = selectedActivityTitle.filter{$0 != allActivitiesList[indexPath.row].activityTitle}
            selectedActivityRecordID = selectedActivityRecordID.filter{$0 != allActivitiesList[indexPath.row].activityRecordID}
            selected = selected.filter{$0 != allActivitiesList[indexPath.row]}
        }
        
        if let sr = tableView.indexPathsForSelectedRows {
            print("didDeselectRowAtIndexPath selected rows:\(sr)")
        }
        
        print(selectedActivityTitle)
        print(selectedActivityRecordID)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as!  ActivityTableViewCell
        
        
        if indexPath.section == 0{
            cell.activityNameLabel.text = lastActivitiesList[indexPath.row].activityTitle
            cell.selectionStyle = .none
            if lastActivitiesList[indexPath.row].isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none) // (3)
            } else {
                tableView.deselectRow(at: indexPath, animated: false) // (4)
            }
//            cell.checkboxButton.tag = indexPath.row
//            cell.checkboxButton.addTarget(self, action: #selector(checkboxTapped(sender:)), for: .touchUpInside)
            
        } else if indexPath.section == 1{
            if allActivitiesList[indexPath.row].isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none) // (3)
            } else {
                tableView.deselectRow(at: indexPath, animated: false) // (4)
            }
            cell.activityNameLabel.text = allActivitiesList[indexPath.row].activityTitle
            cell.selectionStyle = .none
//            cell.checkboxButton.tag = indexPath.row
//            cell.checkboxButton.addTarget(self, action: #selector(checkboxTapped(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
//    @objc func checkboxTapped(sender: UIButton) {
//        let selectLabel = allActivitiesList[sender.tag].activityTitle
//        if sender.isSelected {
//            //uncheck the butoon
//            sender.isSelected = false
//            selectedActivity = selectedActivity.filter{$0 != selectLabel}
//        } else {
//            // checkmark it
//            sender.isSelected = true
//            selectedActivity.append(selectLabel)
//        }
//        print(selectedActivity)
//    }
}
