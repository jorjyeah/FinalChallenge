//
//  TherapyScheduleCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 15/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class TherapyScheduleCKModel: NSObject{
    var record:CKRecord?
    
    var therapyScheduleDay : String {
        get{
            return record?.value(forKey: "therapyScheduleDay") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapyScheduleDay")
        }
    }
    
    var therapyScheduleHour : String {
        get{
            return record?.value(forKey: "therapyScheduleHour") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapyScheduleHour")
        }
    }
    
    var childName : String {
        get{
            return record?.value(forKey: "childName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "childName")
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
    
    init(record:CKRecord){
        self.record = record
    }
}
