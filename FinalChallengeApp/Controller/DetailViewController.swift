//
//  DetailViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityArray = ["Stomp feet", "Point to  body parts", "Extend index finger",  "Place thumbs up"]
    var promptArray = ["Gesture, Physical, Verbal", "Gesture, Physical, Verbal", "Gesture, Physical, Verbal", "Gesture, Physical, Verbal"]
    var mediaArray = ["", "Mirror, Doll", "Mirror, Doll", "Mirror, Doll"]
    
    var howToArray = [""]
    var exampleArray = [""]
    var tipsArray = [""]
    var skillArray = [""]
    var programArray = [""]
    var imageArray = [""]
    var audioArray = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Activities on Friday, 18 Oct 2019"
        }
        else if section == 1 {
            return "Notes"
        }
        else {
            return "Attachments"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activityArray.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section  == 0 {
            return 128
        }
        else if indexPath.section == 1  {
            return 220
        }
        else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
            cell.activityLabel.text = activityArray[indexPath.row]
            cell.promptLabel.text = "Prompt: " + promptArray[indexPath.row]
            cell.mediaLabel.text = "Media: " + mediaArray[indexPath.row]
            
            return  cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as!  NotesTableViewCell
            
            return  cell
        }
        else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "attachmentsCell", for: indexPath) as! AttachmentsTableViewCell
            
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "showViewDetail") as! ViewDetailViewController
        destination.activity = activityArray[indexPath.row]
        destination.prompt = promptArray[indexPath.row]
        destination.media = mediaArray[indexPath.row]
        destination.tips  = mediaArray[indexPath.row]
        destination.skill = mediaArray[indexPath.row]
        destination.program = mediaArray[indexPath.row]

        performSegue(withIdentifier: "showViewDetail", sender: self)
    }
    
}
