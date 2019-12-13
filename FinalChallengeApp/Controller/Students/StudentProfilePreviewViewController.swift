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
    
    
    var scannedString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        studentNameLabel.text = scannedString
    }

}
