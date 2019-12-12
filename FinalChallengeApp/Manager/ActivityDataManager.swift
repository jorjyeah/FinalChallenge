//
//  ActivityDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 09/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class ActivityDataManager{
    class func getActivityCreator(skillRecordID : CKRecord.ID, onComplete: @escaping ([ActivityCKModel]) -> Void){
        var activityModel = [ActivityCKModel]()
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
            
        let predicate = NSPredicate(format: "creatorUserRecordID == %@ AND default == 0 AND skillTitle == %@", creator, skillRecordID)
        
        let query = CKQuery(recordType: "Activity", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = ActivityCKModel(record: record)
                    activityModel.append(model)
                    print("all activities : ",model.activityTitle)
                })
                onComplete(activityModel)
            }
        }
    }
    
    
    class func getActivityDefault(skillRecordID : CKRecord.ID, onComplete: @escaping ([ActivityCKModel]) -> Void){
        var activityModel = [ActivityCKModel]()
       
        let predicate = NSPredicate(format: "default == 1 AND skillTitle == %@", skillRecordID)
        
        let query = CKQuery(recordType: "Activity", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = ActivityCKModel(record: record)
                    activityModel.append(model)
                    print("all activities : ",model.activityTitle)
                })
                onComplete(activityModel)
            }
        }
    }
    
    class func getAllActivity(skillRecordID : CKRecord.ID, onComplete : @escaping ([ActivityCKModel]) -> Void){
       var activitiesModel = [ActivityCKModel]()
       print("masuk getall baseProgram")
        getActivityDefault(skillRecordID: skillRecordID) { (activityModelDef) in
           print("masuk getall baseProgram default")
           activitiesModel = activityModelDef
           getActivityCreator(skillRecordID: skillRecordID) { (activityModelCreator) in
               print("masuk getall skill Creator")
               activitiesModel.append(contentsOf: activityModelCreator)
               onComplete(activitiesModel)
           }
       }
   }
    
    class func addNewActivity(skillRecordID: CKRecord.ID, activityName : String, activityDesc : String, activityMedia : String, activityTips : String, activityPrompts : [String], onComplete: @escaping (CKRecord) -> Void){
        let record = CKRecord(recordType: "Activity")
        let database = CKContainer.default().publicCloudDatabase
        
        let skillReference = CKRecord.Reference(recordID: skillRecordID, action: CKRecord_Reference_Action.none)
        
        record.setObject(skillReference as __CKRecordObjCValue, forKey: "skillTitle")
        record.setValue(activityName, forKey: "activityTitle")
        record.setValue(activityDesc, forKey: "activityDesc")
        record.setValue(activityMedia, forKey: "activityMedia")
        record.setValue(activityTips, forKey: "activityTips")
        record.setValue(activityPrompts, forKey: "activityPrompt")
        record.setValue(0, forKey: "default")
        
        database.save(record) { (savedRecord, error) in
            if let record = savedRecord{
                onComplete(record)
            }else{
                print("err : \(error)")
            }
        }
    }
    
}
