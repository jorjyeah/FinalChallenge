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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewDetailtapped(_ sender: Any) {
        
        
    }
    

}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        
        /*if activityArray[indexPath.row] == "" {
            cell.activityLabel.text = "-"
        }; cell.activityLabel.text = activityArray[indexPath.row]
        
        if promptArray[indexPath.row] == "" {
            cell.promptLabel.text = "-"
        }; cell.promptLabel.text = "Prompt: " + promptArray[indexPath.row]
        
        if mediaArray[indexPath.row] == "" {
            cell.mediaLabel.text = "-"
        }; cell.mediaLabel.text = "Media: " + mediaArray[indexPath.row]*/
        
        cell.activityLabel.text = activityArray[indexPath.row]
        cell.promptLabel.text = "Prompt: " + promptArray[indexPath.row]
        cell.mediaLabel.text = "Media: " + mediaArray[indexPath.row]
        
        return cell

    }
    
}
