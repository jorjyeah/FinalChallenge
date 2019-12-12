//
//  ActivityCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 09/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import Foundation
import CloudKit

class ActivityCKModel{
    var record:CKRecord?
        
    var activityRecordID : CKRecord.ID {
        get{
            return (record?.recordID)!
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
    
    var activityTitle : String {
        get{
            return record?.value(forKey: "activityTitle") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "activityTitle")
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
    
    var skillRecordID : CKRecord.Reference {
        get{
            return record?.value(forKey: "skillTitle") as! CKRecord.Reference
        }
        set{
            self.record?.setValue(newValue, forKey: "skillTitle")
        }
    }
    
    var baseProgram : String!
    
    var skillTitle : String!
    
    var defaultData : Int{
        get{
            return record?.value(forKey: "default") as! Int
        }
    }
    
    init(record : CKRecord){
        self.record = record
    }
}
