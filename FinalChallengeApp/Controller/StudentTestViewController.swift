//
//  StudentTestViewController.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 16/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StudentTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Students View Controller")
        
        StudentCKModel.getStudentData {
            students in
            for student in students {
                print("Student name: \(student.studentName)")
                print(student.studentDOB)
            }
            
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        print(students)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear students")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
