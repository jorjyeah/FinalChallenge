//
//  MaterialsViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 24/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class MaterialsViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let grossMotorArray = ["TO IMPROVE MUSCLE TONE"]
    let fineMotorArray = ["GRASP PATTERN SKILLS", "BILLATERAL COORDINATION", "MANIPULATION SKILLS", "EYE - HAND COORDINATION", "BEHAVIOUR MODIFICATION TECHNIQUE"]
    let programCategory = ["Gross Motor Skill", "Fine Motor Skill"]
    
    var skillData = [CKRecord.ID:[SkillCKModel]]()
    var baseProgram = [BaseProgramCKModel]()
    
    var selectedBaseProgram = String()
    var selectedSkillRecordID = CKRecord.ID()
    var selectedSkillTitle = String()
    
    @IBAction func unwindFromEditMaterials(_ sender:UIStoryboardSegue){
        // bikin function dulu buat unwind, nanti di exit di page summary
        if sender.source is EditMaterialsViewController{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        // Do any additional setup after loading the view.
        collectionView.layer.cornerRadius = 8
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 2)
        collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowRadius = 4
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        populateData()
//    }
    
    func populateData(){
        BaseProgramDataManager.getBaseProgram { (baseProgramModel) in
            self.baseProgram = baseProgramModel
            
            SkillDataManager.getAllSkill { (skillModel) in
                skillModel.map { (skill) in
                    if self.skillData[skill.baseProgramRecordID] == nil{
                        self.skillData[skill.baseProgramRecordID] = []
                    }
                    
                    self.skillData[skill.baseProgramRecordID]?.append(skill)
                }
                
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
}


extension MaterialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseProgram.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subsID = baseProgram[section].baseProgramRecordID

        let skills = skillData[subsID]

        if let unwrapSkills = skills{
            print(unwrapSkills.count)
            return unwrapSkills.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "programCell", for: indexPath) as! ProgramCollectionViewCell
        
        //cell style
        cell.layer.cornerRadius = 8
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 4
        
        if let baseProgram =  skillData[baseProgram[indexPath.section].baseProgramRecordID]{
            cell.programLabel.text = "\(baseProgram[indexPath.row].skillTitle) + \(indexPath.row)"
        }else{
            cell.programLabel.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let baseProgram = skillData[baseProgram[indexPath.section].baseProgramRecordID]{
            self.selectedBaseProgram = self.baseProgram[indexPath.section].baseProgramTitle
            self.selectedSkillRecordID = baseProgram[indexPath.row].skillRecordID
            self.selectedSkillTitle = baseProgram[indexPath.row].skillTitle
            performSegue(withIdentifier: "showActivity", sender: self)
        }
        
//        if indexPath.section == 0 {
//            selectedProgram = grossMotorArray[indexPath.row]
//            performSegue(withIdentifier: "showActivity", sender: self)
//        } else {
//            selectedProgram = fineMotorArray[indexPath.row]
//            performSegue(withIdentifier: "showActivity", sender: self)
//        }
  
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivity" {
            let destination = segue.destination as! ActivityViewController
            destination.baseProgram = selectedBaseProgram
            destination.skillRecordID = selectedSkillRecordID
            destination.skillTitle = selectedSkillTitle
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! HeaderCollectionReusableView
            
            headerView.headerTitle.text = baseProgram[indexPath.section].baseProgramTitle
            return headerView
        }
        fatalError()
    }

    
}
