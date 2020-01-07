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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var studentRecordID = String()
    var hideLastActivity = false
    var sections = ["Last Activities","All Activities"]
    var selectedActivityTitle = [String]()
    var selectedActivityRecordID = [String]()
    var selected = [AddReportModelCK]()
    var allActivitiesList = [AddReportModelCK]()
    var lastActivitiesList =  [AddReportModelCK]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reloadGroup = DispatchGroup()
        tableView.allowsMultipleSelection = true
        
        reloadGroup.enter()
        let allActivityData = AddReportModelCK.self
        allActivityData.getActivity { allActivitiesData in
            self.allActivitiesList = allActivitiesData
            reloadGroup.leave()
            //styling
            self.tableView.separatorColor = .clear
        }
        
        reloadGroup.enter()
        let lastActivityData = AddReportModelCK.self
        lastActivityData.getLastActivity(childRecordID: studentRecordID) { lastActivitiesData in
            if lastActivitiesData.count != 0 {
                self.hideLastActivity = false
                lastActivityData.getActivityBasedOnLastActivities(activitiesRecordID: lastActivitiesData) { activities in
                    self.lastActivitiesList = activities
                    reloadGroup.leave()
                }
            }
            else {
                self.hideLastActivity = true
                reloadGroup.leave()
            }
            
        }
        
        reloadGroup.notify(queue: .main){
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let alert = UIAlertController(title: "Activity not selected", message: "Please select at least one activity", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if segue.identifier == "showSummary" {
            if selected.count == 0{
                self.present(alert, animated: true)
            } else {
//                DispatchQueue.main.async {
                    let destination = segue.destination as! SummaryViewController
                    destination.selectedActivity = self.selected
                    destination.studentRecordID = self.studentRecordID
//                }
            }
        }
    }
}

extension AddReportViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.82)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if hideLastActivity {
                return 0
            } else {
                return lastActivitiesList.count
            }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 && hideLastActivity {
            return UIView.init(frame: CGRect.zero)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && hideLastActivity {
            return 1
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 && hideLastActivity {
            return UIView.init(frame: CGRect.zero)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 && hideLastActivity {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            lastActivitiesList[indexPath.row].isSelected = true
            selected.append(lastActivitiesList[indexPath.row])
            
        } else if indexPath.section == 1 {
            allActivitiesList[indexPath.row].isSelected = true
            selected.append(allActivitiesList[indexPath.row])
        }
        
        if let sr = tableView.indexPathsForSelectedRows {
            print("didDeselectRowAtIndexPath selected rows:\(sr)")
        }
        print(selected)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            lastActivitiesList[indexPath.row].isSelected = false
            selected = selected.filter{$0 != lastActivitiesList[indexPath.row]}
        } else if indexPath.section == 1 {
            allActivitiesList[indexPath.row].isSelected = false
            selected = selected.filter{$0 != allActivitiesList[indexPath.row]}
        }
        
        if let sr = tableView.indexPathsForSelectedRows {
            print("didDeselectRowAtIndexPath selected rows:\(sr)")
        }
        print(selected)
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
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
