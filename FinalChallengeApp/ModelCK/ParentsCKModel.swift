//
//  ParentsCKModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 14/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit
import UIKit

class ParentCKModel{
    var record : CKRecord?
    var parentName : String {
        get{
            return record?.value(forKey: "parentName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }
    
    var parentPhone : String {
        get{
            return record?.value(forKey: "parentPhone") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentPhone")
        }
    }
    
    var parentAddress : String {
        get{
            return record?.value(forKey: "parentAddress") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentAddress")
        }
    }
    
    var parentPhoto : UIImage{
        get{
            if let asset = record?["parentPhoto"] as? CKAsset,
                let data = NSData(contentsOf: (asset.fileURL)!),
                let image = UIImage(data: data as Data)
            {
                return image
            }
            return UIImage(named: "Student Photo Default")!
        }
    }

    init(record: CKRecord){
        self.record = record
    }
    
}
