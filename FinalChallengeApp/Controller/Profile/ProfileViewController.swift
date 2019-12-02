//
//  ProfileViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 24/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePhotoUIImage: UIImageView!
    @IBOutlet weak var nameProfileLabel: UILabel!
    @IBOutlet weak var institutionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
//    var TherapistProfile = [ProfileTherapistCKModel]()
    @IBAction func unwindFromEditProfile(_ sender:UIStoryboardSegue){
        // bikin function dulu buat unwind, nanti di exit di page summary
        if sender.source is EditProfileViewController{
            if let senderVC = sender.source as? EditProfileViewController{
                print(senderVC.test)
//                print(senderVC.selectedActivity)
            }
            populateProfileTherapist()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        populateProfileTherapist()
    }
    
    func populateProfileTherapist(){
        let therapistData = ProfileTherapistCKModel.self
        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
        let therapistName = String(UserDefaults.standard.string(forKey: "therapistName")!)
        
        therapistData.checkTherapistData(userRef: therapistRecordID) { (available) in
            if available{
                therapistData.getTherapistData(userRef: therapistRecordID) { (ProfileTherapistData) in
                    DispatchQueue.main.async {
                        self.nameProfileLabel.text = ProfileTherapistData.therapistName
                        self.profilePhotoUIImage.image = ProfileTherapistData.therapistPhoto
                        if ProfileTherapistData.institutionName == "no data" {
                            self.institutionLabel.text = "Institution name hasn't been set yet"
                        } else {
                            self.institutionLabel.text = ProfileTherapistData.institutionName
                        }
                        
                        if ProfileTherapistData.therapistAddress == "no data" {
                            self.addressLabel.text = "Address hasn't been set yet"
                        } else {
                            self.addressLabel.text = ProfileTherapistData.therapistAddress
                        }
                    }
                }
            } else {
                print("no data")
                self.nameProfileLabel.text = therapistName
                self.profilePhotoUIImage.image = UIImage(named: "Student Photo Default")!
                self.institutionLabel.text = "Institution name hasn't been set yet"
                self.addressLabel.text = "Address hasn't been set yet"
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
