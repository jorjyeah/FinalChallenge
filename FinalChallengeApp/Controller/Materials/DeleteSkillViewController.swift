//
//  DeleteSkillViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class DeleteSkillViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var skillTitleTextView: UITextView!
    
    @IBOutlet weak var deleteSkillButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        skillTitleTextView.delegate = self
        
        skillTitleTextView.text = "Create New Skill"
        skillTitleTextView.textColor = .black
        
        //styling
        backgroundImageView.layer.cornerRadius = 8
        skillTitleTextView.textContainer.maximumNumberOfLines = 4
        skillTitleTextView.textContainer.lineBreakMode = .byClipping
        
        deleteSkillButton.layer.borderWidth = 0.25
        deleteSkillButton.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override func viewDidLayoutSubviews() {
            skillTitleTextView.centerVertically()
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
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Delete This Skill?", message: "All the activities will also be deleted", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            
            //unwind segue ke materialVC
            //self.performSegue(withIdentifier: "unwindToMaterialVC", sender: self)
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        
        alert.addAction(OKAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}


