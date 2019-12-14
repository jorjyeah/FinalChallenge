//
//  StudentProfileViewController.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 14/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {

    var studentModel : StudentCKModel?
    var parentName : String?
    var parentPhone : String?
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var detailsStudent: UILabel!
    @IBOutlet weak var photoProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateData()
    }
    
    func populateData(){
        guard let student = studentModel else {
                return
            }
        
        let form = DateComponentsFormatter()
        form.maximumUnitCount = 2
        form.unitsStyle = .full
        form.allowedUnits = [.year, .month]
        let age = form.string(from: student.studentDOB, to: Date())
        guard let ageInYears = age else { return }
        
        ParentDataManager.getParentsData(parentRecordID: student.parentRecordID) { (parentModel) in
            self.parentName = parentModel.parentName
            self.parentPhone = parentModel.parentPhone
        }
        
        
        photoProfile.image = student.studentPhoto
        studentName.text = student.studentName
        detailsStudent.text = "\(student.studentGender) , \(ageInYears) old"
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension StudentProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsStudent", for: indexPath) as! ReportTableViewCell
        return cell
    }
    
    
}
