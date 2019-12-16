//
//  AudioRecorderViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 10/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

protocol AudioRecorderViewControllerDelegate {
    func sendBack(string: URL)
}

class AudioRecorderViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioFilename = URL(string: "")
    
    var fileName: String = "audioFile.m4a"
    var delegate:AudioRecorderViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //recordButton.setImage(UIImage(named: "play.png"), for: .normal)
        
        recordButton.setImage(UIImage(named: "Record"), for: .normal)
        setupRecorder()

    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder(){
        //let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        let settings = [AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 32000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.2] as [String: Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename!, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer(){
        audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename!)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        playButton.isEnabled = true
//    }
       
    @IBAction func recordAct(_ sender: Any) {
        //recordButton.setImage(UIImage(named: "play.png"), for: .normal)
        if recordButton.titleLabel?.text == "R" {
            audioRecorder.record()
            recordButton.setTitle("S", for: .normal)
            recordButton.setImage(UIImage(named: "Stop Record"), for: .normal)
        } else {
            audioRecorder.stop()
            recordButton.setTitle("R", for: .normal)
            recordButton.setImage(UIImage(named: "Record"), for: .normal)
            self.dismiss(animated: true) {
                self.delegate?.sendBack(string: self.audioFilename!)
            }
            
        }
    }
    
}
