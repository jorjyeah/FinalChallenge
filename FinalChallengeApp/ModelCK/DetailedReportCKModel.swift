//
//  DetailedReportCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 04/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit
import UIKit

class DetailedReportCKModel: NSObject{
    var record:CKRecord?
        
    var activityRecordID : String {
        get{
            return (record?.recordID.recordName)!
        }
    }
    
    var activityTitle : String {
        get{
            return record?.value(forKey: "activityTitle") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityTitle")
        }
    }
    
    var activityDesc : String {
        get{
            return record?.value(forKey: "activityDesc") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityDesc")
        }
    }
    
    var activityMedia : String {
        get{
            return record?.value(forKey: "activityMedia") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityMedia")
        }
    }
    
    var activityTips : String {
        get{
            return record?.value(forKey: "activityTips") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityTips")
        }
    }
    
    var activityPrompt : [String] {
        get{
            return record?.value(forKey: "activityPrompt") as! [String]
        }
        set{
            self.record?.setValue(newValue, forKey: "activityPrompt")
        }
    }
    
    var skillTitle : CKRecord.Reference {
        get{
            return record?.value(forKey: "skillTitle") as! CKRecord.Reference
        }
    }
    
    var baseProgramTitle = String()
    
    init(record:CKRecord){
        self.record = record
    }
}
