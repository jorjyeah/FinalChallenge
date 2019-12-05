//
//  SaveEditedProfile.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 02/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class SaveEditedProfile{
    
    class func saveProfile(newData: [String], newProfilePicture: UIImage, profileData : CKRecord.ID, onComplete: @escaping (Bool) -> Void){
        
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileData) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    return
                }
                guard let record = record else {return}
                
                if !( newData[0] == record["therapistName"] || newData[0] == "" ){
                   record["therapistName"] = newData[0]
                }

                if !( newData[1] == record["institutionName"] || newData[1] == "" ) {
                   record["institutionName"] = newData[1]
                }

                if !( newData[2] == record["therapistAddress"] || newData[2] == "" ){
                   record["therapistAddress"] = newData[2]
                }
                
                let data = newProfilePicture.jpegData(compressionQuality: 90); // UIImage -> NSData, see also UIImageJPEGRepresentation
                let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
                
                do {
                    try data!.write(to: url!, options: [])
                } catch let e as NSError {
                    print("Error! \(e)");
                    return
                }

                record["therapistPhoto"] = CKAsset(fileURL: url!)
                
                CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            return
                        }
                        guard record != nil else {
                            return
                        }
                        
                        do { try FileManager.default.removeItem(at: url!) }
                        catch let e { print("Error deleting temp file: \(e)") }
                        onComplete(true)
                    }
                }
            }
        }
    }
}
