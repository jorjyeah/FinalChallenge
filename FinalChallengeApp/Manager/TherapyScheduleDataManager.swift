//
//  TherapyScheduleDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 13/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class TherapyScheduleDataManager{
    class func checkAvailabilityStudent(studentRecordID: CKRecord.ID, onComplete : @escaping (Bool) -> Void){
        guard let therapistRecordIDString = UserDefaults.standard.string(forKey: "userID") else { return}
        
        let therapistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordIDString), action: CKRecord_Reference_Action.none)
        let studentReference = CKRecord.Reference(recordID: studentRecordID, action: CKRecord_Reference_Action.none)
        
        let predicate = NSPredicate(format: "childName == %@ AND therapistName == %@", therapistReference, studentReference)
        
        let query = CKQuery(recordType: "TherapySchedule", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if records?.count == 0{
                    onComplete(false)
                } else {
                    onComplete(true)
                }
                
            }
        }
    }
    
    class func saveNewTherapySchedule(studentRecordID: CKRecord.ID, onComplete : @escaping (StudentCKModel) -> Void){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "TherapySchedule")
        
        guard let therapistRecordIDString = UserDefaults.standard.string(forKey: "userID") else { return }
        
        let therapistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordIDString), action: CKRecord_Reference_Action.none)
        let studentReference = CKRecord.Reference(recordID: studentRecordID, action: CKRecord_Reference_Action.none)
        
        record.setObject(therapistReference as __CKRecordObjCValue, forKey: "therapistName")
        record.setObject(studentReference as __CKRecordObjCValue, forKey: "childName")
        record.setObject("-" as __CKRecordObjCValue, forKey: "therapyScheduleHour")
        record.setObject("-" as __CKRecordObjCValue, forKey: "therapyScheduleDay")
        
        database.save(record) { (savedRecord, error) in
            guard let saved = savedRecord else {
                return
            }
            getStudentProfile(studentRecordID: studentRecordID) { (studentModel) in
                onComplete(studentModel)
            }
//            let newTherapyModel = StudentCKModel(record: saved)
        }
    }
    
    class func getStudentProfile(studentRecordID : CKRecord.ID, onComplete : @escaping (StudentCKModel) -> Void){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Child", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.fetch(withRecordID: studentRecordID) { (record, error) in
            guard let studentRecord = record else {return}
            onComplete(StudentCKModel(record: studentRecord))
        }
    }
}
