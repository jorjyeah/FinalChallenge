//
//  SkillDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit
import UIKit

class SkillDataManager{
    class func getAllSkillCreator(onComplete : @escaping ([SkillCKModel]) -> Void){
        var skillModel = [SkillCKModel]()
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@ AND default == 0", creator)
        
        let query = CKQuery(recordType: "Skill", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: true)]
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = SkillCKModel(record: record)
                    ReadableData.translateBaseProgram(baseProgramRecordID: model.baseProgramRecordID, onComplete: { (baseProgramTitle) in
                        model.baseProgramTitle = baseProgramTitle
                    })
                    skillModel.append(model)
                })
                onComplete(skillModel)
            }
        }
    }
    
    class func getAllSkillDefault(onComplete : @escaping ([SkillCKModel]) -> Void){
        var skillModel = [SkillCKModel]()
        
        let predicate = NSPredicate(format: "default == 1")
        
        let query = CKQuery(recordType: "Skill", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: true)]
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = SkillCKModel(record: record)
                    ReadableData.translateBaseProgram(baseProgramRecordID: model.baseProgramRecordID, onComplete: { (baseProgramTitle) in
                        model.baseProgramTitle = baseProgramTitle
                    })
                    skillModel.append(model)
                })
                onComplete(skillModel)
            }
        }
    }
    
    
    class func getAllSkill(onComplete : @escaping ([SkillCKModel]) -> Void){
        var skillsModel = [SkillCKModel]()
        print("masuk getall skill")
        getAllSkillDefault { (skillModelDef) in
            print("masuk getall skill default")
            skillsModel = skillModelDef
            getAllSkillCreator { (skillModelCreator) in
                print("masuk getall skill Creator")
                skillsModel.append(contentsOf: skillModelCreator)
                onComplete(skillsModel)
            }
        }
    }
    
    
    
    class func saveNewSkill(baseProgramRecordID : CKRecord.ID, skillTitle : String, onComplete: @escaping(SkillCKModel) -> Void){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "Skill")
        
        let baseProgramReference = CKRecord.Reference(recordID: baseProgramRecordID, action: CKRecord_Reference_Action.none)
        
        record.setObject(baseProgramReference as __CKRecordObjCValue, forKey: "baseProgramTitle")
        record.setObject(skillTitle as __CKRecordObjCValue, forKey: "skillTitle")
        record.setObject(0 as __CKRecordObjCValue, forKey: "default")
        
        database.save(record) { (savedRecord, error) in
            if let record = savedRecord{
                let newRecord = SkillCKModel(record: record)
                onComplete(newRecord)
            }
            print("err : \(error)")
        }
    }
}


