//
//  StudentCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 14/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class StudentCKModel: NSObject{
    // student = child
    var record: CKRecord?
    
    var studentRecordID : String {
        get{
            return record?.recordID.recordName as! String
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
    
    var studentDOB : Date {
        get{
            return record?.value(forKey: "childDOB") as! Date
        }
        set{
            self.record?.setValue(newValue, forKey: "childDOB")
        }
    }
    
    var studentPhoto : UIImage{
        get{
            if let asset = record?["childPhoto"] as? CKAsset,
                let data = try? NSData(contentsOf: (asset.fileURL)!),
                let image = UIImage(data: data as Data)
            {
                return image
            }
            return UIImage(named: "Student Photo Default")!
        }
    }
    
    var parentRecordID : String{
        get{
            if record?.value(forKey: "parentName") != nil{
                return self.record?.value(forKey: "parentName") as! String
            } else{
                return "No Parent"
            }
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }

    init(record: CKRecord){
        self.record = record
    }
    
    class func getTherapySchedule(onComplete : @escaping ([String]) -> Void){
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let therapistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistRecordID), action: CKRecord_Reference_Action.none)

        let predicate = NSPredicate(format: "therapistName == %@", therapistReference)
//        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "TherapySchedule", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["childName"]
        
        var studentsRecordID = [String] ()
        
        operation.recordFetchedBlock = { record in
            let studentReference = record.object(forKey: "childName") as! CKRecord.Reference
            let studentRecordID =  studentReference.recordID.recordName
            
            studentsRecordID.append(studentRecordID)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    print(studentsRecordID.removingDuplicates())
                    onComplete(studentsRecordID.removingDuplicates()) // removing duplicate of multiple string
                } else {
                    print("error : \(error as Any)")
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    print(cursor as Any)
                }
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    class func getStudentData(studentsRecordID : [String], onComplete: @escaping ([StudentCKModel]) -> Void){
        var studentModel = [StudentCKModel]()
        print(studentsRecordID)
        var studentsReference = [CKRecord.Reference]()
        studentsRecordID .forEach { (studentRecordID) in
            // change [string] to [reference]
            studentsReference.append(CKRecord.Reference(recordID: CKRecord.ID(recordName: studentRecordID), action: CKRecord_Reference_Action.none))
        }
        let predicate = NSPredicate(format: "recordID IN %@", argumentArray: [studentsReference])
        //filter using [reference]
        
        let query = CKQuery(recordType: "Child", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = StudentCKModel(record: record)
//                    print("model",model)
                    studentModel.append(model)
                    
                })
//                print("complete")
                onComplete(studentModel)
            }
        }
    }
    
    // bikin function buat request friend
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
