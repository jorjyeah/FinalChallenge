//
//  DetailViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 20/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class DetailTherapistReportViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var audioAttachmentButton: UIButton!
    
    @IBOutlet weak var imageAttachment: UIImageView!
    
    
    var detailActivity = [DetailedReportCKModel]()
    var therapySessionRecordID = CKRecord.ID()
    var therapySessionNotes = String()
    var therapySessionDate = Date()
    
    
    //audio
    var fileName: String = "audioFile.m4a"
    var audioData = Data()
    var audioFilename = URL(string: "")
    var audioPlayer: AVAudioPlayer!
    
    
    
    func getActivitySession(){
        print(therapySessionNotes)
        DetailedReportDataManager.getDetailedTherapySession(therapySessionRecordID: therapySessionRecordID) { (activityRecordsID) in
            DetailedReportDataManager.getDetailedActivity(activityRecordID: activityRecordsID) { (DetailActivitiesData) in
                self.detailActivity = DetailActivitiesData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        DetailedReportDataManager.getAudio(therapySessionRecordID: therapySessionRecordID) { (audioNSURL) in
            if audioNSURL != nil{
                self.setupPlayer(audioNSURL: audioNSURL)
                self.audioAttachmentButton.isEnabled = true
            }
        }
        
        DetailedReportDataManager.getPhoto(therapySessionRecordID: therapySessionRecordID) { (imagePhoto) in
            guard let photo = imagePhoto as? UIImage else {
                return
            }
            self.imageAttachment.image = photo
            self.imageAttachment.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getActivitySession()
        // Do any additional setup after loading the view.
        audioAttachmentButton.isEnabled = false
        imageAttachment.isHidden = true
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        
        audioAttachmentButton.setImage(recordingPlay, for: .normal)
    }
    
    
    //play audio
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupPlayer(audioNSURL : NSURL){
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: audioNSURL as URL)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        
        audioAttachmentButton.setTitle("Play", for: .normal)
        audioAttachmentButton.setImage(recordingPlay, for: .normal)
    }
    
    
    @IBAction func playAct(_ sender: Any) {
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        let recordingPause = UIImage(named: "Recordings Pause")?.withRenderingMode(.alwaysOriginal)
        
        if audioAttachmentButton.titleLabel?.text == "Play" {
            audioAttachmentButton.setTitle("Stop", for: .normal)
//            DetailedReportDataManager.getAudio(therapySessionRecordID: therapySessionRecordID) { (audioNSURL) in
//                self.setupPlayer(audioNSURL: audioNSURL)
            self.audioPlayer.play()
            //playButton.setImage(UIImage(named: "Recordings Pause"), for: .normal)
            self.audioAttachmentButton.setImage(recordingPause, for: .normal)
//            }
        } else {
            audioPlayer.stop()
            audioAttachmentButton.setTitle("Play", for: .normal)
            //playButton.setImage(UIImage(named: "Recordings Play"), for: .normal)
            audioAttachmentButton.setImage(recordingPlay, for: .normal)
            
        }
    }
    
    
}


extension DetailTherapistReportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMM yyyy"
            return "Activities on \(formatter.string(from: therapySessionDate))" // diganti date dari Data
        }
        else {
            return "Notes"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return detailActivity.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section  == 0 {
            return 128
        }
        else {
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var prompts = String()
            detailActivity[indexPath.row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
            cell.activityLabel.text = detailActivity[indexPath.row].activityTitle
            cell.promptLabel.text = "Prompt: " + prompts
            cell.mediaLabel.text = "Media: " + detailActivity[indexPath.row].activityMedia
            
            return  cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as!  NotesTableViewCell
            cell.notesLabel.text = therapySessionNotes
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showViewDetailReport", sender: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showViewDetailReport" {
            let destination = segue.destination as? ViewDetailReportViewController
            let row = sender as! Int
            var prompts = String()
            detailActivity[row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            
            destination?.activity = detailActivity[row].activityTitle
            destination?.howTo = detailActivity[row].activityDesc
            destination?.prompt = prompts
            print(prompts)
            destination?.media = detailActivity[row].activityMedia
            destination?.tips  = detailActivity[row].activityTips
            destination?.skill = detailActivity[row].skillTitle.recordID
            destination?.program = CKRecord.ID(recordName: detailActivity[row].baseProgramTitle)
        }
    }
}
