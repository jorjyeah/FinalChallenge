//
//  EditMaterialsViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class EditMaterialsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var skillData = [CKRecord.ID:[SkillCKModel]]()
    var baseProgram = [BaseProgramCKModel]()
    var newbaseProgram = [BaseProgramCKModel]()
    
    
//    var selectedSkillRecordID = CKRecord.ID()
//    var selectedSkillTitle = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated:true);
        populateData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        populateData()
//    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToMaterialsFromEditMaterials", sender: nil)
    }
    
    @IBAction func unwindFromAddNewSkill(_ sender:UIStoryboardSegue){
        // bikin function dulu buat unwind, nanti di exit di page summary
        if sender.source is NewSkillViewController{
            
        }
    }
    
    func populateData(){
        BaseProgramDataManager.getBaseProgram { (baseProgramModel) in
            self.baseProgram = baseProgramModel
            self.newbaseProgram = baseProgramModel
            SkillDataManager.getAllSkill { (skillModel) in
                skillModel.map { (skill) in
                    if self.skillData[skill.baseProgramRecordID] == nil{
                        self.skillData[skill.baseProgramRecordID] = []
                    }
                    
                    self.skillData[skill.baseProgramRecordID]?.append(skill)
                }
                
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
//                    self.collectionView.collectionViewLayout.invalidateLayout()
                }
            }
        }
        
    }
}

extension EditMaterialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  baseProgram.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subsID = baseProgram[section].baseProgramRecordID

        let skills = skillData[subsID]
        
        if let unwrapSkills = skills{
            print(section)
            print(unwrapSkills.count)
            return unwrapSkills.count + 1
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "programCell", for: indexPath) as! EditProgramCollectionViewCell
        
        //cell style
        cell.layer.cornerRadius = 8
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 4
        
        
        if indexPath.row == skillData[baseProgram[indexPath.section].baseProgramRecordID]?.count{
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProgramCell", for: indexPath) as! AddProgramCollectionViewCell
                addCell.layer.cornerRadius = 8
            return addCell

        } else {
            if let baseProgram =  skillData[baseProgram[indexPath.section].baseProgramRecordID]{
                cell.programLabel.text = "\(baseProgram[indexPath.row].skillTitle) + \(indexPath.row)"
            }else{
                cell.programLabel.text = ""
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { // for header
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerSection", for: indexPath) as! HeaderEditCollectionReusableView
            // ini header textnya (editable)
            headerView.editHeaderTitle.text = baseProgram[indexPath.section].baseProgramTitle
            return headerView
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == skillData[baseProgram[indexPath.section].baseProgramRecordID]?.count{
            performSegue(withIdentifier: "showAddSkill", sender: indexPath.section)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddSkill" {
            let section = sender as! Int
            let destination = segue.destination as! NewSkillViewController
            destination.baseProgramRecordID = baseProgram[section].baseProgramRecordID
        }
    }
}
