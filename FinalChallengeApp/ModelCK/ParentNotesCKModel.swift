//
//  ParentNotesCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 19/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class ParentNotesCKModel: NSObject{
    var record:CKRecord?
    
    var parentNoteDay : Date {
        get{
            return record?.value(forKey: "parentNoteDay") as! Date
        }
        set{
            self.record?.setValue(newValue, forKey: "parentNoteDay")
        }
    }
    
    var parentNoteContent : String {
        get{
            return record?.value(forKey: "parentNoteContent") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentNoteContent")
        }
    }
    
    var therapySession : String {
        get{
            return record?.value(forKey: "therapySession") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapySession")
        }
    }
    
    var studentName : String {
        get{
            return record?.value(forKey: "childName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "childName")
        }
    }
    
    var parentName : String {
        get{
            return record?.value(forKey: "parentName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    class func getParentNotes(studentRecordID : String, onComplete: @escaping ([ParentNotesCKModel]) -> Void){
        var parentNotesModel = [ParentNotesCKModel]()
        
        let studentReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: studentRecordID), action: CKRecord_Reference_Action.none)
        
        let predicate = NSPredicate(format: "childName == %@", studentReference)
        
        let query = CKQuery(recordType: "ParentNotes", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = ParentNotesCKModel(record: record)
                    print("model",model)
                    parentNotesModel.append(model)
                })
                print("complete")
                print("parentNotesModel",parentNotesModel)
                onComplete(parentNotesModel)
            }
        }
//        print("therapySessionModel",parentNotesModel)
    }
}

