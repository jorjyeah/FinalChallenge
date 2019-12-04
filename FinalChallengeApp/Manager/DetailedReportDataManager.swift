//
//  DetailedReportData.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit
import UIKit

class DetailedReportDataManager{
    
    class func getBaseProgram(skillTitle: CKRecord.Reference, onComplete: @escaping (String) -> Void){
        // inside second function
        let predicate = NSPredicate(format: "recordID == %@", skillTitle)
        let query = CKQuery(recordType: "Skill", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["baseProgramTitle"]
        
        var baseProgramsRecordID = String()
        
        operation.recordFetchedBlock = { record in
            let baseProgramReference = record.object(forKey: "baseProgramTitle") as! CKRecord.Reference
            let baseProgramRecordID =  baseProgramReference.recordID.recordName
            
            baseProgramsRecordID.append(baseProgramRecordID)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
//                        print(baseProgramsRecordID)
                    onComplete(baseProgramsRecordID) // removing duplicate of multiple string
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
    
    class func getDetailedActivity(activityRecordID : [CKRecord.ID], onComplete: @escaping ([DetailedReportCKModel]) -> Void){
        // second
        var activityReportModel = [DetailedReportCKModel]()
    
        let predicate = NSPredicate(format: "recordID IN %@", activityRecordID)
//        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Activity", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = DetailedReportCKModel(record: record)
                    getBaseProgram(skillTitle: model.skillTitle) { baseProgramTitle in
//                        print(baseProgramTitle)
                        model.baseProgramTitle = baseProgramTitle
                    }
                    activityReportModel.append(model)
                    print("all activities : ",model.activityTitle)
                })
                onComplete(activityReportModel)
            }
        }
    }
    
    class func getDetailedTherapySession(therapySessionRecordID : CKRecord.ID, onComplete: @escaping ([CKRecord.ID]) -> Void){
        // this function must start first -> get activityRecordID
        var activityRecordID = [CKRecord.ID]()
        
        let therapySessionReference = CKRecord.Reference(recordID: therapySessionRecordID, action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "therapySession == %@", therapySessionReference)
        let query = CKQuery(recordType: "ActivitySessions", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["activityReference"]
        
        operation.recordFetchedBlock = { record in
            let activityReference = record.object(forKey: "activityReference") as! CKRecord.Reference
            activityRecordID.append(activityReference.recordID)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    onComplete(activityRecordID)
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
