//
//  SkillDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class SkillDataManager{
    class func getAllSkill(onComplete : @escaping ([SkillCKModel]) -> Void){
        var skillModel = [SkillCKModel]()
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
            
    
        let predicate = NSPredicate(format: "creatorUserRecordID == %@ AND default == 1", creator)
//        let predicate = NSPredicate(value: true)
        
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
}
