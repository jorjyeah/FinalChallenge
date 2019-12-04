//
//  TherapySessionCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 18/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class TherapySessionCKModel: NSObject{
    var record:CKRecord?
    
   var therapySessionRecordID : CKRecord.ID {
        get{
            return record!.recordID
        }
    }
    
    var therapySessionDate : Date {
        get{
            return record?.value(forKey: "therapySessionDate") as! Date
        }
        set{
            self.record?.setValue(newValue, forKey: "therapySessionDate")
        }
    }
    
    var therapySessionNotes : String {
        get{
            return record?.value(forKey: "therapySessionNotes") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapySessionNotes")
        }
    }
    
    var childName : String {
        get{
            return record?.value(forKey: "childName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "childName")
        }
    }
    
    var therapistName : String {
        get{
            return record?.value(forKey: "therapistName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistName")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    class func getTherapySession(studentRecordID : String, onComplete: @escaping ([TherapySessionCKModel]) -> Void){
        var therapySessionModel = [TherapySessionCKModel]()
        
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        
        let studentReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: studentRecordID), action: CKRecord_Reference_Action.none)
        let therapistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
        
        let predicate = NSPredicate(format: "childName == %@ AND therapistName  == %@", studentReference, therapistReference)
        
        let query = CKQuery(recordType: "TherapySession", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "therapySessionDate", ascending: false)]
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = TherapySessionCKModel(record: record)
                    print("model",model)
                    therapySessionModel.append(model)
                    // harus append or = aja?
                })
                print("complete")
                print("therapySessionModel",therapySessionModel)
                onComplete(therapySessionModel)
            }
        }
//        print("therapySessionModel",therapySessionModel)
    }
}
