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
    
//    let therapistReportArray = ["Fri, 18 Oct 2019",  "Wed, 16 Oct 2019", "Mon, 14 Oct 2019"]
//    let parentsReportArray = ["Thu, 17 Oct 2019", "Tue, 15 Oct 2019"]
    
    let therapySessionDateArray = ["November"]
    
    //ini buat nampung student record id yg di-passing dari StudentVC
    var studentRecordID = String()
    var therapySession = [TherapySessionCKModel]()
    var parentsNotesData = [ParentNotesCKModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.separatorColor = .clear
        //navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateTableView()
    }
    
    
    func populateTableView(){
        //navigationController?.navigationBar.prefersLargeTitles = false
        let therapySessionsData = TherapySessionCKModel.self
        therapySessionsData.getTherapySession(studentRecordID: studentRecordID) { therapySessionsData in
            self.therapySession = therapySessionsData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        DetailedParentNotesDataManager.getParentNotes(studentRecordID: studentRecordID) {
            parentsNotesData
            in
            self.parentsNotesData = parentsNotesData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func segmentedTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func unwindFromSummary(_ sender:UIStoryboardSegue){
        // bikin function dulu buat unwind, nanti di exit di page summary
        if sender.source is SummaryViewController{
            if let senderVC = sender.source as? SummaryViewController{
                tableView.reloadData()
                print(senderVC.test)
                print(senderVC.selectedActivity)
            }
        }
    }
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
        return therapySessionDateArray.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //ini masih belum fix
//        /*for i in 0..<therapySessionDateArray.count {
//            if section == 0 {
//                return "\(therapySessionDateArray[i])"
//            }
//            else {
//                return "\(therapySessionDateArray[i+1])"
//            }
//        }*/
//        return "November"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return therapySession.count
            
        case 1:
            return parentsNotesData.count
            
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportTableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy, HH:mm a"
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let therapySessionDate = formatter.string(from: therapySession[indexPath.row].therapySessionDate)
            cell.reportLabel.text = therapySessionDate
            
        case 1:
            let parentNotesDate = formatter.string(from: parentsNotesData[indexPath.row].parentNoteDay)
            cell.reportLabel.text = parentNotesDate
            
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "showTherapistDetail", sender: indexPath.row)
        case 1:
            performSegue(withIdentifier: "showParentsDetail", sender: indexPath.row)
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddReport" {
            let destination = segue.destination as! AddReportViewController
            destination.studentRecordID = studentRecordID
            print("\(destination.studentRecordID)")
        } else if segue.identifier == "showTherapistDetail" {
            let destination = segue.destination as? DetailTherapistReportViewController
            let row = sender as! Int
            destination?.therapySessionRecordID = therapySession[row].therapySessionRecordID
            destination?.therapySessionNotes = therapySession[row].therapySessionNotes
            destination?.therapySessionDate = therapySession[row].therapySessionDate
        } else if segue.identifier == "showParentsDetail" {
            let destination = segue.destination as? ParentsDetailViewController
            let row = sender as! Int
            destination?.parentNote = parentsNotesData[row].parentNoteContent
            destination?.parentNoteDate = parentsNotesData[row].parentNoteDay
        }
    }
}
