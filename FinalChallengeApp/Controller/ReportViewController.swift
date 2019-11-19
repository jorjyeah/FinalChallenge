//
//  ReportViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 19/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    let therapistReportArray = ["Fri, 18 Oct 2019",  "Wed, 16 Oct 2019", "Mon, 14 Oct 2019"]
    let parentsReportArray = ["Thu, 17 Oct 2019", "Tue, 15 Oct 2019"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func segmentedTapped(_ sender: Any) {
        tableView.reloadData()
    }
    

}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return therapistReportArray.count
            
        case 1:
            return parentsReportArray.count
            
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportTableViewCell
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.reportLabel.text = therapistReportArray[indexPath.row]
            
        case 1:
            cell.reportLabel.text = parentsReportArray[indexPath.row]
            
        default:
            break
        }
        return cell
    }
    
}