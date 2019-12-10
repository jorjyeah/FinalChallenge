//
//  ActivityDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 09/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class ActivityDataManager{
    class func getActivity(skillRecordID : CKRecord.ID, onComplete: @escaping ([ActivityCKModel]) -> Void){
        var activityModel = [ActivityCKModel]()
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
            
    
        let predicate = NSPredicate(format: "creatorUserRecordID == %@ AND default == 1 AND skillTitle == %@", creator, skillRecordID)
//        let predicate = NSPredicate(value: true)
        
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
    
    
}
