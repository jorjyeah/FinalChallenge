//
//  ActivityModelCK.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 25/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class AddReportModelCK: NSObject{
    var record:CKRecord?
    
    var activityRecordID : String {
        get{
            return (record?.recordID.recordName)!
        }
    }
    
    var activityTitle : String {
        get{
            return record?.value(forKey: "activityTitle") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityTitle")
        }
    }
    
    var activityDesc : String {
        get{
            return record?.value(forKey: "activityDesc") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityDesc")
        }
    }
    
    var activityMedia : String {
        get{
            return record?.value(forKey: "activityMedia") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityMedia")
        }
    }
    
    var activityTips : String {
        get{
            return record?.value(forKey: "activityTips") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityTips")
        }
    }
    
    var activityPrompt : [String] {
        get{
            return record?.value(forKey: "activityPrompt") as! [String]
        }
        set{
            self.record?.setValue(newValue, forKey: "activityPrompt")
        }
    }
    
    var skillTitle : CKRecord.Reference {
        get{
            return record?.value(forKey: "skillTitle") as! CKRecord.Reference
        }
    }
    
    var baseProgramTitle = String()
    
    var isSelected =  false
    
    init(record:CKRecord){
        self.record = record
    }
    
    class func getLastActivity(onComplete: @escaping ([String]) -> Void){
        print("ambil aktivitas terakhir")
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
    
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", creator)
        let query = CKQuery(recordType: "ActivitySessions", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: true)]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["activityReference"]
        
        var activitiesRecordID = [String] ()
        
        operation.recordFetchedBlock = { record in
            let activityReference = record.object(forKey: "activityReference") as! CKRecord.Reference
            let activityRecordID =  activityReference.recordID.recordName
            
            activitiesRecordID.append(activityRecordID)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
//                    print(activitiesRecordID.removingDuplicates())
                    onComplete(activitiesRecordID.removingDuplicates()) // removing duplicate of multiple string
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
    
    class func getActivityBasedOnLastActivities(activitiesRecordID : [String], onComplete: @escaping ([AddReportModelCK]) -> Void){
        print("ambil semua aktivitas berdasarkan aktivitas terakhir")
//        print(activitiesRecordID)
        var activityReportModel = [AddReportModelCK]()
        var activityReference = [CKRecord.Reference]()
        activitiesRecordID .forEach { (activitiyRecordID) in
            // change [string] to [reference]
            activityReference.append(CKRecord.Reference(recordID: CKRecord.ID(recordName: activitiyRecordID), action: CKRecord_Reference_Action.none))
        }
//        print(activityReference)
        let predicate = NSPredicate(format: "recordID in %@", argumentArray: [activityReference])
        
        let query = CKQuery(recordType: "Activity", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = AddReportModelCK(record: record)
                    getBaseProgram(skillTitle: model.skillTitle) { baseProgramTitle in
//                        print(baseProgramTitle)
                        model.baseProgramTitle = baseProgramTitle
                        
                    }
                    activityReportModel.append(model)
                    print("last activities : ",model.activityTitle)
                })
                onComplete(activityReportModel)
            }
        }
    }
    class func getBaseProgram(skillTitle: CKRecord.Reference, onComplete: @escaping (String) -> Void){
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
    
    class func getActivity(onComplete: @escaping ([AddReportModelCK]) -> Void){
        print("ambil semua aktivitas")
        var activityReportModel = [AddReportModelCK]()
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
    
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Activity", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = AddReportModelCK(record: record)
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
}
