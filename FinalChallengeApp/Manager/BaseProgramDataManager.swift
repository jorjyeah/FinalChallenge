//
//  baseProgramDataManager.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class BaseProgramDataManager{
    class func getBaseProgramCreator(onComplete : @escaping ([BaseProgramCKModel]) -> Void){
        var baseProgramModel = [BaseProgramCKModel]()
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let creator = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)
                    
            
        let predicate = NSPredicate(format: "creatorUserRecordID == %@ AND default == 0", creator)
//        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "BaseProgram", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = BaseProgramCKModel(record: record)
                    baseProgramModel.append(model)
                })
                onComplete(baseProgramModel)
            }
        }
    }
    
    class func getBaseProgramDefault(onComplete : @escaping ([BaseProgramCKModel]) -> Void){
        var baseProgramModel = [BaseProgramCKModel]()
                    
        let predicate = NSPredicate(format: "default == 1")
//        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "BaseProgram", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = BaseProgramCKModel(record: record)
                    baseProgramModel.append(model)
                })
                onComplete(baseProgramModel)
            }
        }
    }
    
    class func getAllBaseProgram(onComplete : @escaping ([BaseProgramCKModel]) -> Void){
        var baseProgramsModel = [BaseProgramCKModel]()
        print("masuk getall baseProgram")
        getBaseProgramDefault { (baseProgramModelDef) in
            print("masuk getall baseProgram default")
            baseProgramsModel = baseProgramModelDef
            getBaseProgramCreator { (baseProgramModelCreator) in
                print("masuk getall skill Creator")
                baseProgramsModel.append(contentsOf: baseProgramModelCreator)
                onComplete(baseProgramsModel)
            }
        }
    }
//    class func saveEdited(baseProgramsRecordID : [CKRecord.ID], baseProgramsTitle : [String], onComplete: @escaping(Bool) -> Void){
//        let database = CKContainer.default().publicCloudDatabase
//        
//        basePrograms
//        database.fetch(withRecordID: baseProgramRecordID) { (baseProgramRecord, error) in
//            <#code#>
//        }
//        let record = CKRecord(recordType: "BaseProgram")
//        
//        record.setObject(baseProgramTitle as __CKRecordObjCValue, forKey: "baseProgramTitle")
//        
//        database.save(record) { (savedRecord, error) in
//            if let record = savedRecord{
//                onComplete(record.recordID, baseProgramTitle)
//            }
//            print("err : \(error)")
//        }
//    }
}
