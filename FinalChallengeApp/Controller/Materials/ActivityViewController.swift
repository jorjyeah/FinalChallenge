//
//  ActivityViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 24/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var programTitle: String = ""
    let activityTaskArray = ["Activity #1", "Activity #2", "Activity #3", "Activity #4", "Activity #5", "Activity #6", "Activity #7"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}



extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return activityTaskArray.count
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
            cell.programTitleLabel.text = programTitle
            
            return  cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityTaskCell", for: indexPath) as!  ActivityTaskTableViewCell
            cell.activityTaskLabel.text = activityTaskArray[indexPath.row]
        
            return  cell
        }
        
    }
    
    
}
