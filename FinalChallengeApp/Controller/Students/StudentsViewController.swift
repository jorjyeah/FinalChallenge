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
//    let studentNameArray = ["Bianca", "Dea", "George", "Daniel"]
    var filteredData = [StudentCKModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar customize
        //navigationController?.navigationBar.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
     

        // search bar
        searchBar.delegate =  self
        
        let studentsData = StudentCKModel.self
        studentsData.getTherapySchedule{ studentsRecordID in
            print("studentsRecordID:\(studentsRecordID)")
            studentsData.getStudentData(studentsRecordID: studentsRecordID) { studentsData in
                self.student = studentsData // tampung data semua
                self.filteredData = studentsData // tampung data yang terfilter
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}


extension StudentsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "All Student"
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count // HItung data yang terfilter, biar dinamis
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentsTableViewCell
        
        cell.studentNameLabel.text = filteredData[indexPath.row].studentName //[BI]
        cell.studentPhotoImageView.layer.cornerRadius = 25
        cell.studentPhotoImageView.image = filteredData[indexPath.row].studentPhoto

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

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filter data sudah pakai data model
        filteredData = searchText.isEmpty ? student : student.filter({ (students) -> Bool in
            return students.studentName.range(of: searchText, options: .caseInsensitive) != nil
        })
        print("data student filtered : \(filteredData)")
        tableView.reloadData()
    }
    
    //[BI] ini untuk cancel
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = student // reset data ulang
        tableView.reloadData()
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

//extension UIViewController {
//
//    func setLargeTitleDisplayMode(_ largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode) {
//        switch largeTitleDisplayMode {
//        case .automatic:
//              guard let navigationController = navigationController else { break }
//            if let index = navigationController.children.firstIndex(of: self) {
//                setLargeTitleDisplayMode(index == 0 ? .always : .never)
//            } else {
//                setLargeTitleDisplayMode(.always)
//            }
//        case .always, .never:
//            navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
//            // Even when .never, needs to be true otherwise animation will be broken on iOS11, 12, 13
//            navigationController?.navigationBar.prefersLargeTitles = true
//        @unknown default:
//            assertionFailure("\(#function): Missing handler for \(largeTitleDisplayMode)")
//        }
//    }
//}
