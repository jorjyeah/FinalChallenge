//
//  BaseProgramCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 06/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class BaseProgramCKModel{
    
    var record:CKRecord?
    
    var baseProgramRecordID : CKRecord.ID{
        get{
            return (record?.recordID)!
        }
        set{
            self.record?.setValue(newValue, forKey: "recordName")
        }
    }
    
    var defaultData : Int{
        get{
            return record?.value(forKey: "default") as! Int
        }
        set{
            self.record?.setValue(newValue, forKey: "default")
        }
    }
    
    var baseProgramTitle : String{
        get{
            return record?.value(forKey: "baseProgramTitle") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "baseProgramTitle")
        }
    }
    
    init(record : CKRecord?){
        self.record = record
    }
}
