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
    }
    
    var defaultData : Int{
        get{
            return record?.value(forKey: "default") as! Int
        }
    }
    
    var baseProgramTitle : String{
        get{
            return record?.value(forKey: "baseProgramTitle") as! String
        }
    }
    
    init(record : CKRecord){
        self.record = record
    }
}
