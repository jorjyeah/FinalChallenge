//
//  ParentDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 14/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ParentDataManager{
    class func getParentsData(parentRecordID: String, onComplete : @escaping (ParentCKModel) -> Void){
        let recordID = CKRecord.ID(recordName: parentRecordID)
        
        let database = CKContainer.default().publicCloudDatabase
        database.fetch(withRecordID: recordID) { (record, error) in
            guard let parentRecord = record else {
                return
            }
            onComplete(ParentCKModel(record: parentRecord))
        }
    }
}
