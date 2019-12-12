//
//  ReadableData.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ReadableData{
    class func translateSkill(skillRecordID: CKRecord.ID, onComplete: @escaping (String) -> Void){
        // inside second function
        let predicate = NSPredicate(format: "recordID == %@", skillRecordID)
        let query = CKQuery(recordType: "Skill", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["skillTitle"]
        
        var skillTitle = String()
        
        operation.recordFetchedBlock = { record in
            skillTitle = record.object(forKey: "skillTitle") as! String
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
//                        print(baseProgramsRecordID)
                    onComplete(skillTitle) // removing duplicate of multiple string
                } else {
                    print("error : \(error as Any)")
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    print(cursor as Any)
                }
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    class func translateBaseProgram(baseProgramRecordID: CKRecord.ID, onComplete: @escaping (String) -> Void){
        // inside second function
        let predicate = NSPredicate(format: "recordID == %@", baseProgramRecordID)
        let query = CKQuery(recordType: "BaseProgram", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["baseProgramTitle"]
        
        var baseProgramTitle = String()
        
        operation.recordFetchedBlock = { record in
            baseProgramTitle = record.object(forKey: "baseProgramTitle") as! String
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
//                        print(baseProgramsRecordID)
                    onComplete(baseProgramTitle) // removing duplicate of multiple string
                } else {
                    print("error : \(error as Any)")
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    print(cursor as Any)
                }
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
