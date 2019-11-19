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
            return record?.value(forKey: "therapySchedulNotes") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapyScheduleNotes")
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
    
    class func getTherapySession(studentRecordID : String, therapistRecordID : String, onComplete: @escaping ([TherapySessionCKModel]) -> Void){
        var therapySessionModel = [TherapySessionCKModel]()
        
        let studentReference = CKRecord.Reference(recordID: CKRecord.ID.value(forKey: studentRecordID) as! CKRecord.ID, action: CKRecord_Reference_Action.none)
        let therapistReference = CKRecord.Reference(recordID: CKRecord.ID.value(forKey: therapistRecordID) as! CKRecord.ID, action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "childName == %@ AND therapistName  == %@",[studentReference, therapistReference])
        
        let query = CKQuery(recordType: "TherapySession", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = TherapySessionCKModel(record: record)
                    print("model",model)
                    therapySessionModel.append(model)
                })
                print("complete")
                onComplete(therapySessionModel)
            }
        }
        print("therapySessionModel",therapySessionModel)
    }
    
    class func addTherapySession(){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "TherapySession")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:MM"
        let therapySessionDate = formatter.string(from: Date())
        let therapySessionNotes = "Please repeat activity one"
        record.setObject(therapySessionDate as __CKRecordObjCValue, forKey: "therapySessionDate")
        record.setObject(therapySessionNotes as __CKRecordObjCValue, forKey: "therapySessionNotes")
        database.save(record) { savedRecord, error in
            // handle errors here
        }
    }
}
