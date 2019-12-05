//
//  NewSkillViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 05/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class NewSkillViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var skillTitleTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        skillTitleTextView.delegate = self
        
        skillTitleTextView.text = "Create New Skill"
        skillTitleTextView.textColor = .black
        
        
        //styling
        backgroundImageView.layer.cornerRadius = 8
        
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if skillTitleTextView.textColor == .black && skillTitleTextView.isFirstResponder {
            skillTitleTextView.text = nil
            skillTitleTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if skillTitleTextView.text.isEmpty || skillTitleTextView.text == "" {
            skillTitleTextView.textColor = .black
            skillTitleTextView.text = "Create New Skill"
            skillTitleTextView.resignFirstResponder()
        }
    }
   

}
