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
    
    class func saveNewBaseProgram(baseProgramRecord : CKRecord, onComplete: @escaping(Bool) -> Void){
        let database = CKContainer.default().publicCloudDatabase
        
        database.save(baseProgramRecord) { (savedRecord, error) in
            if let record = savedRecord{
                onComplete(true)
            }
        }
    }
    
    class func saveEdited(baseProgramRecord : [BaseProgramCKModel], onComplete: @escaping(Bool) -> Void){
        let database = CKContainer.default().publicCloudDatabase
        var ckRecordBaseProgram = [CKRecord]()
        var ckRecordIDBaseProgram = [CKRecord.ID]()
        
        baseProgramRecord .forEach { (baseProgram) in
            print(baseProgram.baseProgramRecordID)
            ckRecordBaseProgram.append(baseProgram.record!)
            ckRecordIDBaseProgram.append(baseProgram.baseProgramRecordID)
        }
        
        let saveRecordsOperation = CKModifyRecordsOperation(recordsToSave: ckRecordBaseProgram, recordIDsToDelete: nil)

        saveRecordsOperation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordIDs, error in
            if let saved = savedRecords{
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        
        database.add(saveRecordsOperation)
    }
}
