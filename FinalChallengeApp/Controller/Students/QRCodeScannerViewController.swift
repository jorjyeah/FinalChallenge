//
//  QRCodeScannerViewController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 13/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var scannerView: UIView!
    
    var imageOrientation: AVCaptureVideoOrientation?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    var scannedString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
             fatalError("No video device found")
         }
         
         self.imageOrientation = AVCaptureVideoOrientation.portrait
                               
         do {
             let input = try AVCaptureDeviceInput(device: captureDevice)
                    
             captureSession = AVCaptureSession()
             captureSession?.addInput(input)
                    
             capturePhotoOutput = AVCapturePhotoOutput()
             capturePhotoOutput?.isHighResolutionCaptureEnabled = true
                    
             captureSession?.addOutput(capturePhotoOutput!)
             captureSession?.sessionPreset = .high
                    
             let captureMetadataOutput = AVCaptureMetadataOutput()
             captureSession?.addOutput(captureMetadataOutput)
                    
             captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
             captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                    
             videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
             videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
             videoPreviewLayer?.frame = view.layer.bounds
             scannerView.layer.addSublayer(videoPreviewLayer!)

             //start video capture
             captureSession?.startRunning()
        
         } catch {
             //If any error occurs, simply print it out
             print(error)
             return
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.captureSession?.startRunning()
    }
   
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }
        
        return nil
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                           didOutput metadataObjects: [AVMetadataObject],
                           from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is contains at least one object.
        if metadataObjects.count == 0 {
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            if let outputString = metadataObj.stringValue {
                DispatchQueue.main.async {
                    print(outputString)
                    self.scannedString = outputString
                    self.performSegue(withIdentifier: "showProfilePreview", sender: self)
                }
            }
        }
        
        self.captureSession?.stopRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfilePreview" {
            if let destination = segue.destination as? StudentProfilePreviewViewController {
                destination.scannedString = scannedString
            }
        }
    }

}
