//
//  ParentsDetailViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 25/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ParentsDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       let layer = UIView()
        layer.frame = CGRect(x: 16, y: 137, width: 382, height: 104)
        layer.backgroundColor = .white
        layer.layer.cornerRadius = 14
        layer.layer.borderWidth = 0.3
        layer.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        view.addSubview(layer)
        
        // Do any additional setup after loading the view.
    }
    

    

}
