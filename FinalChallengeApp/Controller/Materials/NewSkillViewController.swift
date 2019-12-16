//
//  NewSkillViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 05/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class NewSkillViewController: UIViewController, UITextViewDelegate {
    
    var baseProgramRecordID = CKRecord.ID()
    var skillModel : SkillCKModel?
    
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
        skillTitleTextView.textContainer.maximumNumberOfLines = 4
        skillTitleTextView.textContainer.lineBreakMode = .byClipping
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToEditMaterialsFromAddNewSkill" {
            let destination = segue.destination as! EditMaterialsViewController
            guard let skillModel = skillModel else { return }
            destination.skillData[baseProgramRecordID]?.append(skillModel)
        }
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        let newSkillTitle = skillTitleTextView.text
        if !(newSkillTitle == "Create New Skill" || newSkillTitle == ""){
            SkillDataManager.saveNewSkill(baseProgramRecordID: baseProgramRecordID, skillTitle: newSkillTitle!) { (newSkillModel) in
                if newSkillModel != nil {
                    self.skillModel = newSkillModel
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "backToEditMaterialsFromAddNewSkill", sender: nil)
                    }
                }
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}
