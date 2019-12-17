//
//  EditProfileViewController.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 01/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class EditProfileViewController: StaraLoadingViewController {
    var test:String = ""
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var institutionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var profileImageVIew: UIImageView!
    var newProfilePicture = UIImage(systemName: "person.circle")
    let therapistData = ProfileTherapistCKModel.self
    var imagePicker: ImagePicker!
    var newData = [String]()
    
    
    @IBAction func editPhotoButton(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageVIew.layer.cornerRadius = 78
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
        let reloadGroup = DispatchGroup()
        configureLoading()
        reloadGroup.enter()
        ProfileTherapistCKModel.getTherapistData(userRef:therapistRecordID) { profileData in
            reloadGroup.enter()
            SaveEditedProfile.saveProfile(newData: self.newData, newProfilePicture: self.newProfilePicture!, profileData: profileData.therapistRecordID) { (success) in
                if success {
                    reloadGroup.leave()
                    
                }
            }
            reloadGroup.leave()
        }
        
        reloadGroup.notify(queue: .main){
            self.dismissLoading()
            self.performSegue(withIdentifier: "backToProfile", sender: nil)
        }
    }
    
    func populateProfileTherapist(){
        let theraphistData = ProfileTherapistCKModel.self
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let therapistName = String(UserDefaults.standard.string(forKey: "therapistName")!)
        let reloadGroup = DispatchGroup()
        startLoading()
        reloadGroup.enter()
        theraphistData.checkTherapistData(userRef: therapistRecordID) { (available) in
            if available{
                reloadGroup.enter()
                theraphistData.getTherapistData(userRef: therapistRecordID) { (ProfileTherapistData) in
                    reloadGroup.leave()
                    DispatchQueue.main.async {
                        self.nameTextField.text = ProfileTherapistData.therapistName
                        self.profileImageVIew.image = ProfileTherapistData.therapistPhoto
                        self.newProfilePicture = ProfileTherapistData.therapistPhoto
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
                reloadGroup.leave()
                print("no data")
                self.nameTextField.text = therapistName
                //self.profileImageVIew.image = UIImage(named: "Student Photo Default")!
                self.institutionTextField.placeholder = "Institution name hasn't been set yet"
                self.addressTextField.placeholder = "Address hasn't been set yet"
                
            }
            reloadGroup.leave()
        }
        
        reloadGroup.notify(queue: .main){
            self.dismissLoading()
        }
    }
}

extension EditProfileViewController : ImagePickerDelegate, UITextFieldDelegate {
    func didSelect(image: UIImage?) {
        self.profileImageVIew.image = image
        newProfilePicture = (image ?? UIImage(named: "Student Photo Default"))!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        
        if textField == nameTextField {
            let maxLength = 20
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else if textField == institutionTextField {
            let maxLength = 25
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else {
            let maxLength = 50
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        
//        let currentString: NSString = textField.text! as NSString
//        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
    }
    
}
