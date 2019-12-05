//
//  ViewDetailViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewDetailViewController: UIViewController {
    
    var activity: String = ""
    var prompt: String = ""
    var media: String = ""
    var howTo: String = ""
    var example: String = ""
    var tips: String = ""
    var skill: String = ""
    var program: String = ""
    var image: UIImage = UIImage()
    var audio: AVAudioFile = AVAudioFile()
    
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var howToLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    @IBOutlet weak var helpfulTipsLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var imageAttachmentLabel: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityNameLabel.text = activity
        howToLabel.text = howTo
        promptLabel.text = prompt
        mediaLabel.text = media
        helpfulTipsLabel.text = tips
        skillLabel.text = skill
        programLabel.text = program
    }

}
