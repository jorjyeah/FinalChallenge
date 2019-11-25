//
//  StudentsViewController.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 13/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        

    var student = [StudentCKModel]()
    var recordIDTransfer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Students"
        
        
        let studentsData = StudentCKModel.self
        studentsData.getTherapySchedule{ studentsRecordID in
            print("studentsRecordID:\(studentsRecordID)")
            studentsData.getStudentData(studentsRecordID: studentsRecordID) { studentsData in
                self.student = studentsData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    /*override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           self.retrieveCanteenData()
           self.navigationController?.navigationBar.prefersLargeTitles = true
           self.setNeedsStatusBarAppearanceUpdate()
           
       }*/
    

}


extension StudentsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "All Student"
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.student.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentsTableViewCell
        
        cell.studentNameLabel.text = student[indexPath.row].studentName
        cell.studentPhotoImageView.layer.cornerRadius = 25
        cell.studentPhotoImageView.image = student[indexPath.row].studentPhoto

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recordIDTransfer = student[indexPath.row].studentRecordID
        performSegue(withIdentifier: "showStudentReport", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStudentReport" {
            let destination = segue.destination as! ReportViewController
            destination.studentRecordID = recordIDTransfer
            
            print("\(destination.studentRecordID)")
        }
    }
    
}
