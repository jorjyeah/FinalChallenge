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
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var institutionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var profileImageVIew: UIImageView!
    var newProfilePicture = UIImage(named: "Student Photo Default")
    let therapistData = ProfileTherapistCKModel.self
    var imagePicker: ImagePicker!
    var newData = [String]()
    
//    override func prepare(for segue:
//        UIStoryboardSegue, sender: Any?) {
//        // ini unwind segue ke profilevc
//        test = "coba save"
//        saveEditedProfile()
//    }

    
    @IBAction func editPhotoButton(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageVIew.layer.cornerRadius = 50
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        populateProfileTherapist()
        
        nameTextField.delegate = self
        institutionTextField.delegate = self
        addressTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        newData.append(String(nameTextField.text!))
        newData.append(String(institutionTextField.text!))
        newData.append(String(addressTextField.text!))
        ProfileTherapistCKModel.getTherapistData(userRef:therapistRecordID) { profileData in
            SaveEditedProfile.saveProfile(newData: self.newData, newProfilePicture: self.newProfilePicture!, profileData: profileData.therapistRecordID) { (success) in
                if success {
                    self.performSegue(withIdentifier: "backToProfile", sender: nil)
                }
//                print(success)
            }
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

extension EditProfileViewController : ImagePickerDelegate, UITextFieldDelegate {
    func didSelect(image: UIImage?) {
        self.profileImageVIew.image = image
        newProfilePicture = (image ?? UIImage(named: "Student Photo Default"))!
    }
    
}
