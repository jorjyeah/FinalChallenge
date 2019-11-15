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
    
    var nameArray = ["Bianka Aristania", "Aurelia Natasha", "Stefani Vania", "Tamara Liem"]
    var scheduleArray = ["Selasa", "Rabu", "Senin", "Selasa"]
    var imageArray = [UIImage(named: "Bianka"), UIImage(named: "Aurelia"), UIImage(named: "Stefani"), UIImage(named: "Tamara")]
    
    
    //var student: [Student] = []
    var student = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Students"

        
        for i in 0..<nameArray.count{
            let data = Student(name: nameArray[i], schedule: scheduleArray[i], image: imageArray[i]!)
            student.append(data)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentsTableViewCell
        
        cell.studentName.text = student[indexPath.row].name
        
        
        cell.studentImage.layer.cornerRadius = 25
        cell.studentImage.image = student[indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStudentReport", sender: self)
    }
    
    
    
}
