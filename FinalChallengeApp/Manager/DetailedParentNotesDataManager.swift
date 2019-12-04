//
//  DetailedParentNotesDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 05/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class DetailedParentNotesDataManager{
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
