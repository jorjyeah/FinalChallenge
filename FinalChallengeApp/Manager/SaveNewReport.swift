//
//  SaveNewReport.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 03/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit
import UIKit
import AVFoundation

class SaveNewReport{
    
    class func saveReport(childName: String, therapistName: String, therapySessionNotes: String, onComplete: @escaping (CKRecord.ID) -> Void){
        // save buat untuk dapet therapy session ID
        // yang nantinya disave di activitySessions
        var therapySessionRecordID = CKRecord.ID()
        let dateNow = Date()
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "TherapySession")
        
        let childRecordID = CKRecord.Reference(recordID: CKRecord.ID(recordName: childName), action: CKRecord_Reference_Action.none)
        let therapistRecordID = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistName), action: CKRecord_Reference_Action.none)
        
        record.setObject(childRecordID as __CKRecordObjCValue, forKey: "childName")
        record.setObject(therapistRecordID as __CKRecordObjCValue, forKey: "therapistName")
        record.setObject(dateNow as __CKRecordObjCValue, forKey: "therapySessionDate")
        record.setObject("notes" as __CKRecordObjCValue, forKey: "therapySessionNotes")
        database.save(record) { (savedRecord, error) in
            if savedRecord != nil{
                therapySessionRecordID = savedRecord!.recordID
                print(therapySessionRecordID.recordName)
                onComplete(therapySessionRecordID)
            }
            print("err : \(error)")
        }
    }
    
    class func saveActivitySessions(activityReference: String, childName: String, therapySession: CKRecord.ID, onComplete: @escaping (Bool) -> Void){
        
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "ActivitySessions")
        
        let childRecordID = CKRecord.Reference(recordID: CKRecord.ID(recordName: childName), action: CKRecord_Reference_Action.none)
        let therapySessionRecordID = CKRecord.Reference(recordID: therapySession, action: CKRecord_Reference_Action.none)
        let activityRecordID = CKRecord.Reference(recordID: CKRecord.ID(recordName: activityReference), action: CKRecord_Reference_Action.none)
        
        record.setObject(childRecordID as __CKRecordObjCValue, forKey: "childName")
        record.setObject(therapySessionRecordID as __CKRecordObjCValue, forKey: "therapySession")
        record.setObject(activityRecordID as __CKRecordObjCValue, forKey: "activityReference")
        
        database.save(record) { (savedRecord, error) in
            if savedRecord != nil{
                onComplete(true)
            }
            print("err : \(error)")
        }
    }
    
    
    
    
    class func saveAudio(therapySession: CKRecord.ID, audio: Data, onComplete: @escaping (Bool) -> Void){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "Audio")
        
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        
        do {
            try audio.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        
        let therapySessionRecordID = CKRecord.Reference(recordID: therapySession, action: CKRecord_Reference_Action.none)
        record.setObject(therapySessionRecordID as __CKRecordObjCValue, forKey: "ext")
        record.setObject(CKAsset(fileURL: url!), forKey: "sound")
        
        database.save(record) { (savedRecord, error) in
            if (savedRecord != nil){
                onComplete(true)
            } else{
                print(error)
            }
        }
    }
    
    
    
    
    
    
    class func savePhoto(therapySession: CKRecord.ID, photo: UIImage, onComplete: @escaping (Bool) -> Void){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "Photo")
        
        let data = photo.jpegData(compressionQuality: 90); // UIImage -> NSData, see also UIImageJPEGRepresentation
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        
        do {
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        
        let therapySessionRecordID = CKRecord.Reference(recordID: therapySession, action: CKRecord_Reference_Action.none)
        record.setObject(therapySessionRecordID as __CKRecordObjCValue, forKey: "ext")
        record.setObject(CKAsset(fileURL: url!), forKey: "image")
        
        database.save(record) { (savedRecord, error) in
            if (savedRecord != nil){
                onComplete(true)
            } else{
                print(error)
            }
        }
    }
}
