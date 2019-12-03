//
//  ProfileTherapistCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit
import UIKit

class ProfileTherapistCKModel: NSObject{
    var record:CKRecord?
    
    var therapistRecordID : CKRecord.ID {
        get{
            return record!.recordID
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
    
    var therapistAddress : String {
        get{
            if let therapistAddress = record?.value(forKey: "therapistAddress"){
                return therapistAddress as! String
            } else {
                return "no data"
            }
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistAddress")
        }
    }
    
    var institutionName : String {
        get{
            if let institutionName = record?.value(forKey: "institutionName"){
                return institutionName as! String
            } else {
                return "no data"
            }
        }
        set{
            self.record?.setValue(newValue, forKey: "institutionName")
        }
    }
    
    var therapistPhoto : UIImage{
        get{
            if let asset = record?["therapistPhoto"] as? CKAsset,
                let data = NSData(contentsOf: (asset.fileURL)!),
                let image = UIImage(data: data as Data)
            {
                return image
            }
            return UIImage(named: "Student Photo Default")!
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
    
    class func addNewTherapist(therapistName: String, userReference: String, onComplete: @escaping(Bool) -> ()){
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "Therapist")
        record.setObject(therapistName as __CKRecordObjCValue, forKey: "therapistName")
        let userReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: userReference), action: CKRecord_Reference_Action.none)
        record.setObject(userReference as __CKRecordObjCValue, forKey: "userReference")
        database.save(record) { savedRecord, error in
            if error != nil{
                print("saved : \(savedRecord!)")
                onComplete(true)
            } else {
                // handle errors here
                print("error saved: \(error!)")
                onComplete(false)
            }
        }
    }
    
    class func getTherapistData(userRef: String, onComplete: @escaping(ProfileTherapistCKModel) -> Void){
        let userReference =  CKRecord.Reference(recordID: CKRecord.ID(recordName: userRef), action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "userReference == %@", userReference)
        
        let query = CKQuery(recordType: "Therapist", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        var profileTherapistModel : ProfileTherapistCKModel? = nil
        database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                records?.forEach({ (record) in
                    let model = ProfileTherapistCKModel(record: record)
                    profileTherapistModel = model
                })
                onComplete(profileTherapistModel ?? error as! ProfileTherapistCKModel)
            }
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
