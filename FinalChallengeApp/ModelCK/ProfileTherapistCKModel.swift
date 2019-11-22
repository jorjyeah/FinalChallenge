//
//  ProfileTherapistCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class profileTherapistCKModel: NSObject{
    var record:CKRecord?
    
    var therapistName : String {
        get{
            return record?.value(forKey: "therapistName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistName")
        }
    }
    
    var therapistAddress : String {
        get{
            return record?.value(forKey: "therapistAddress") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistAddress")
        }
    }
    
    var institutionName : String {
        get{
            return record?.value(forKey: "institutionName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "institutionName")
        }
    }
    
    var therapistPhoto : String {
        get{
            return record?.value(forKey: "therapistPhoto") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistPhoto")
        }
    }
    
    var userReference : String {
        get{
            return record?.value(forKey: "userReference") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "userReference")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    class func addNewTherapist(therapistName: String, userReference: String){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "Therapist")
        record.setObject(therapistName as __CKRecordObjCValue, forKey: "therapistName")
        let userReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: userReference), action: CKRecord_Reference_Action.none)
        record.setObject(userReference as __CKRecordObjCValue, forKey: "userReference")
        database.save(record) { savedRecord, error in
            print("saved : \(savedRecord)")
            print("error : \(error)")
            // handle errors here
        }
    }
    
    class func checkTherapistData(userRef: String, onComplete: @escaping(Bool) -> ()){
        let userReference =  CKRecord.Reference(recordID: CKRecord.ID(recordName: userRef), action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "userReference == %@", userReference)
        
        let query = CKQuery(recordType: "Therapist", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if records!.count != 0{
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
    }
}
