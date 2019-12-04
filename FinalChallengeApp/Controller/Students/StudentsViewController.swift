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
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    var student = [StudentCKModel]()
    var recordIDTransfer: String = ""
    
    //[BI] search bar
    let studentNameArray = ["Bianca", "Dea", "George", "Daniel"]
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar customize
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Students"
        
        
        //[BI] search bar
        searchBar.delegate =  self
        filteredData = studentNameArray
        
        
        /*let studentsData = StudentCKModel.self
        studentsData.getTherapySchedule{ studentsRecordID in
            print("studentsRecordID:\(studentsRecordID)")
            studentsData.getStudentData(studentsRecordID: studentsRecordID) { studentsData in
                self.student = studentsData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }*/
    }

}


extension StudentsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.82)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "All Student"
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.student.count
        return filteredData.count //[BI]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentsTableViewCell
        
        
        cell.studentNameLabel.text = filteredData[indexPath.row] //[BI]
        /*cell.studentNameLabel.text = student[indexPath.row].studentName
        cell.studentPhotoImageView.layer.cornerRadius = 25
        cell.studentPhotoImageView.image = student[indexPath.row].studentPhoto*/

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //recordIDTransfer = student[indexPath.row].studentRecordID
        performSegue(withIdentifier: "showStudentReport", sender: self)
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStudentReport" {
            let destination = segue.destination as! ReportViewController
            destination.studentRecordID = recordIDTransfer
            
            print("\(destination.studentRecordID)")
        }
    }*/
    

    
    //[BI] search bar (masih pakai array)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? studentNameArray : studentNameArray.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    
    
    //[BI] ini untuk cancel
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
}
