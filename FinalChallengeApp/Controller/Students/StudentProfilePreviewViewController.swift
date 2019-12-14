//
//  StudentProfilePreviewViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 13/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StudentProfilePreviewViewController: UIViewController {
    
    @IBOutlet weak var studentNameLabel: UILabel!
    
    var newStudent : StudentCKModel?
    var scannedString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        studentNameLabel.text = scannedString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFullProfile"{
            let destination = segue.destination as! StudentProfileViewController
            destination.studentModel = newStudent
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func seeFullProfile(_ sender: Any) {
        performSegue(withIdentifier: "showFullProfile", sender: self)
    }
    
}
