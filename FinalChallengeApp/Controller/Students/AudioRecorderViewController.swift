//
//  AudioRecorderViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 10/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorderViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioFilename = URL(string: "")
    
    var fileName: String = "audioFile.m4a"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //recordButton.setImage(UIImage(named: "play.png"), for: .normal)
        
        recordButton.setImage(UIImage(named: "Record"), for: .normal)
        
        setupRecorder()
        playButton.isEnabled = false

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
        //let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
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
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
    }
       
    @IBAction func recordAct(_ sender: Any) {
        //recordButton.setImage(UIImage(named: "play.png"), for: .normal)
        if recordButton.titleLabel?.text == "R" {
            audioRecorder.record()
            recordButton.setTitle("S", for: .normal)
            recordButton.setImage(UIImage(named: "Stop Record"), for: .normal)
            playButton.isEnabled = false
        } else {
            audioRecorder.stop()
            recordButton.setTitle("R", for: .normal)
            recordButton.setImage(UIImage(named: "Record"), for: .normal)
            playButton.isEnabled = false
        }
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        dismiss(animated: true, completion: nil)
//        var destination = segue.destination as? SummaryViewController {
//
//        }
//
//    }

    @IBAction func playAct(_ sender: Any) {
        if playButton.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            setupPlayer()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = true
        }
    }
    
}
