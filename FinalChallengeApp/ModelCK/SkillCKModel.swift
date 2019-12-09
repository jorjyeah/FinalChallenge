//
//  SkillCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class SkillCKModel{
    var record:CKRecord?
        
    var skillRecordID : CKRecord.ID {
        get{
            return (record?.recordID)!
        }
    }
    
    var skillTitle : String {
        get{
            return record?.value(forKey: "skillTitle") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "skillTitle")
        }
    }
    
    var baseProgramRecordID : CKRecord.ID{
        get{
            let reference = record?.value(forKey: "baseProgramTitle") as! CKRecord.Reference
            
            return reference.recordID
        }
        set{
            self.record?.setValue(newValue, forKey: "baseProgramTitle")
        }
    }
    
    var defaultData : Int{
        get{
            return record?.value(forKey: "default") as! Int
        }
    }
    
    var baseProgramTitle : String?
    
    init(record : CKRecord){
        self.record = record
    }
}
