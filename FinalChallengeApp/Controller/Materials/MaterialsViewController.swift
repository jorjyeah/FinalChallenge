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
    let programCategory = ["Gross Motor Skill", "Fine Motor Skill"]
    
    var selectedProgram: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.layer.cornerRadius = 8
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 2)
        collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowRadius = 4
    }

}


extension MaterialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  programCategory.count
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
        
        //cell style
        cell.layer.cornerRadius = 8
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 4
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! HeaderCollectionReusableView
            
            if indexPath.section == 0 {
                headerView.headerTitle.text = programCategory[indexPath.row]
                return headerView
            } else {
                headerView.headerTitle.text = programCategory[indexPath.row+1]
                return headerView
            }
        }
        fatalError()
    }

    
}
