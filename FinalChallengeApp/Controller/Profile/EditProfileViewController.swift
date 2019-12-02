//
//  EditProfileViewController.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 01/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    var test:String = ""
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var institutionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    override func prepare(for segue:
        UIStoryboardSegue, sender: Any?) {
        // ini unwind segue ke profilevc
        test = "coba save"
        saveEditedProfile()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateProfileTherapist()
        // Do any additional setup after loading the view.
    }
    
    func uploadPhoto(){
        
    }
    
    func saveEditedProfile(){
        let therapistData = ProfileTherapistCKModel.self
        var newData = [String]()
        newData.append(String(self.nameTextField.text!))
        newData.append(String(self.institutionTextField.text!))
        newData.append(String(self.addressTextField.text!))
        print(newData)
        therapistData.updateTherapistData(newData : newData) { (success) in
            print(success)
        }
        
    }
    
    func populateProfileTherapist(){
        let theraphistData = ProfileTherapistCKModel.self
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let therapistName = String(UserDefaults.standard.string(forKey: "therapistName")!)
        
        theraphistData.checkTherapistData(userRef: therapistRecordID) { (available) in
            if available{
                theraphistData.getTherapistData(userRef: therapistRecordID) { (ProfileTherapistData) in
                    DispatchQueue.main.async {
                        self.nameTextField.text = ProfileTherapistData.therapistName
                        self.profileImageVIew.image = ProfileTherapistData.therapistPhoto
                        
                        if ProfileTherapistData.institutionName == "no data" {
                            self.institutionTextField.placeholder = "Institution name hasn't been set yet"
                        } else {
                            self.institutionTextField.text = ProfileTherapistData.institutionName
                        }
                        
                        if ProfileTherapistData.therapistAddress == "no data" {
                            self.addressTextField.placeholder = "Address hasn't been set yet"
                        } else {
                            self.addressTextField.text = ProfileTherapistData.therapistAddress
                        }
                    }
                }
            } else {
                print("no data")
                self.nameTextField.text = therapistName
                self.profileImageVIew.image = UIImage(named: "Student Photo Default")!
                self.institutionTextField.placeholder = "Institution name hasn't been set yet"
                self.addressTextField.placeholder = "Address name hasn't been set yet"
            }
        }
    }
}
