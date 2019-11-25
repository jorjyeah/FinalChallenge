//
//  MaterialsViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 24/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class MaterialsViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let grossMotorArray = ["TO IMPROVE MUSCLE TONE, STRENGTH, ENDURANCE", "TO IMPROVE BALANCE", "TO IMPROVE UPPER / LOWER LIMB COORDINATION", "TO IMPROVE VISUAL MOTOR INTEGRATION"]
    let fineMotorArray = ["GRASP PATTERN SKILLS", "BILLATERAL COORDINATION", "MANIPULATION SKILLS", "EYE - HAND COORDINATION", "BEHAVIOUR MODIFICATION TECHNIQUE"]
    let programCategory = ["Gross Motor", "Fine Motor"]
    
    var selectedProgram: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension MaterialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return grossMotorArray.count
        } else {
            return fineMotorArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "programCell", for: indexPath) as! ProgramCollectionViewCell
        
        if indexPath.section == 0 {
            cell.programLabel.text = grossMotorArray[indexPath.row]
            return cell
        } else {
            cell.programLabel.text = fineMotorArray[indexPath.row]
            return cell
        }
   
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            selectedProgram = grossMotorArray[indexPath.row]
            performSegue(withIdentifier: "showActivity", sender: self)
        } else {
            selectedProgram = fineMotorArray[indexPath.row]
            performSegue(withIdentifier: "showActivity", sender: self)
        }
  
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivity" {
            let destination = segue.destination as! ActivityViewController
            destination.programTitle = selectedProgram
        }
    }
    
}
