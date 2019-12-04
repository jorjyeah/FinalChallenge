//
//  ParentNotesCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 19/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class ParentNotesCKModel: NSObject{
    var record:CKRecord?
    
    var parentNoteDay : Date {
        get{
            return record?.value(forKey: "parentNoteDay") as! Date
        }
        set{
            self.record?.setValue(newValue, forKey: "parentNoteDay")
        }
    }
    
    var parentNoteContent : String {
        get{
            return record?.value(forKey: "parentNoteContent") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentNoteContent")
        }
    }
    
    var therapySession : String {
        get{
            return record?.value(forKey: "therapySession") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapySession")
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
    
    var parentName : String {
        get{
            return record?.value(forKey: "parentName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
}

