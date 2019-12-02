//
//  AddStudentViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 29/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class AddStudentViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var videoPreview: UIView!
    
    
    var stringURL = String()
    
    enum error: Error {
        case noCameraAvailable
        case videoInputInitFail
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        do {
            try scanQrCode()
        } catch {
            print("Failed to scan theb QR Code")
        }
        
    }
    
    
    
    func captureOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [Any], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                stringURL = machineReadableCode.stringValue!
                performSegue(withIdentifier: "showNewStudentPreview", sender: self)
            }
        }
    }
    
    func scanQrCode() throws {
        let avCaptureSession = AVCaptureSession()
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Can not access camera")
            throw error.noCameraAvailable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Failed to init camera")
            throw error.videoInputInitFail
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        avCaptureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewStudentPreview" {
            let destination = segue.destination as! NewStudentPreviewViewController
            //destination.url = URL(string: stringURL)
        }
    }

}
