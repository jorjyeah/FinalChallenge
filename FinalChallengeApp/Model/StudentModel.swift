//
//  StudentModel.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 16/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import Foundation
import UIKit

class StudentModel {
    var studentRecordID: String
    var parentRecordID: String
    var studentName: String
    var studentSchedule: String
    var studentPhoto: UIImage
    
    init(studentName: String, studentSchedule: String, studentPhoto: UIImage, studentRecordID: String, parentRecordID: String){
        self.studentName = studentName
        self.studentSchedule = studentSchedule
        self.studentPhoto = studentPhoto
        self.studentRecordID = studentRecordID
        self.parentRecordID = parentRecordID
    }
    
}
