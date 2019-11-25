//
//  ActivityModelCK.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 25/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ActivityReportModelCK: NSObject{
    var record:CKRecord?
    
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
    
    var skillTitle : [String] {
        get{
            return record?.value(forKey: "skillTitle") as! [String]
        }
        set{
            self.record?.setValue(newValue, forKey: "skillTitle")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    class func getLast(onComplete: @escaping ([ActivityReportModelCK]) -> Void){
        print("ambil aktivitas terakhir")
        var activityReportModel = [ActivityReportModelCK]()
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
                    let model = ActivityReportModelCK(record: record)
                    print("model",model)
                    activityReportModel.append(model)
                })
                print("complete")
                print("activityReportModel",activityReportModel)
                onComplete(activityReportModel)
            }
        }
    }
    
    class func getActivity(onComplete: @escaping ([ActivityReportModelCK]) -> Void){
        print("ambil semua aktivitas")
        var activityReportModel = [ActivityReportModelCK]()
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
                    let model = ActivityReportModelCK(record: record)
                    print("model",model)
                    activityReportModel.append(model)
                })
                print("complete")
                print("activityReportModel",activityReportModel)
                onComplete(activityReportModel)
            }
        }
    }
}
