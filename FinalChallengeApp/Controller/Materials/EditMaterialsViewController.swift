//
//  EditMaterialsViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class EditMaterialsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var grossMotorArray = ["TO IMPROVE MUSCLE TONE, STRENGTH, ENDURANCE", "TO IMPROVE BALANCE", "TO IMPROVE UPPER / LOWER LIMB COORDINATION", "TO IMPROVE VISUAL MOTOR INTEGRATION"]
    let fineMotorArray = ["GRASP PATTERN SKILLS", "BILLATERAL COORDINATION", "MANIPULATION SKILLS", "EYE - HAND COORDINATION", "BEHAVIOUR MODIFICATION TECHNIQUE"]
    let programCategory = ["Gross Motor Skill", "Fine Motor Skill"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    

}

extension EditMaterialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  programCategory.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return grossMotorArray.count+1
        } else {
            return fineMotorArray.count+1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "programCell", for: indexPath) as! EditProgramCollectionViewCell
        
        //cell style
        cell.layer.cornerRadius = 8
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 4
        
        if indexPath.row == grossMotorArray.count, indexPath.section == 0 {
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProgramCell", for: indexPath) as! AddProgramCollectionViewCell
                addCell.layer.cornerRadius = 8
            return addCell
        } else if indexPath.row == fineMotorArray.count, indexPath.section == 1 {
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProgramCell", for: indexPath) as! AddProgramCollectionViewCell
                addCell.layer.cornerRadius = 8
            return addCell
        } else {
            if indexPath.section == 0 {
                cell.programLabel.text = grossMotorArray[indexPath.row]
                return cell
                
            } else {
                cell.programLabel.text = fineMotorArray[indexPath.row]
                return cell
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerSection", for: indexPath) as! HeaderEditCollectionReusableView
            
            if indexPath.section == 0 {
                headerView.editHeaderTitle.text = programCategory[indexPath.row]
                return headerView
            } else {
                headerView.editHeaderTitle.text = programCategory[indexPath.row+1]
                return headerView
            }
        }
        fatalError()
    }  
}
