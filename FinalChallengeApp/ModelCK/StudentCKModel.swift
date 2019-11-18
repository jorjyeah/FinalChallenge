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
            return record?.value(forKey: "recordName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "recordName")
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
            return UIImage(named: "default")!
        }
    }
    
    var parentRecordID : String{
        get{
            return record?.value(forKey: "parentName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }

    
    init(record: CKRecord){
        self.record = record
    }
    
    class func getStudentData(onComplete: @escaping ([StudentCKModel]) -> Void){
        var studentData = [StudentCKModel]()
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Child", predicate: predicate)
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = StudentCKModel(record: record)
                    print("model",model)
                    studentData.append(model)
                    
                })
                print("complete")
                onComplete(studentData)
            }
        }
        print(studentData)
//        return studentData
    }

}

