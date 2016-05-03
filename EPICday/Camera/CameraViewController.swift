//
//  CameraViewController.swift
//  EPICday
//
//  Created by Max Mamis on 5/2/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import GPUImage
import Firebase

enum Status: Int {
    case Preview, Still, Error
}

class CameraViewController: UIViewController {
    
    var selectedChannel: Channel?
    
    @IBOutlet private weak var cameraStillView: UIImageView!
    @IBOutlet private weak var cameraPreviewContainerView: UIView!
    @IBOutlet private weak var captureButton: UIButton!
    @IBOutlet private weak var cameraTransitionView: UIView!
    @IBOutlet private weak var cameraOverlayView: UIView!
    @IBOutlet private weak var cameraStillWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var cameraCaptureCheckMarkView: CheckMarkView!
    
    private lazy var cameraPreviewView: GPUImageView = {
        let previewView = GPUImageView()
        previewView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill
        return previewView
    }()
    
    private lazy var captureFilter: GPUImageFilter = {
        guard let filterURL = NSBundle.mainBundle().URLForResource("Castillero", withExtension: "acv") else {
            fatalError("Could not load filter")
        }
        let filter = GPUImageToneCurveFilter(ACVURL:filterURL)
        filter.addTarget(self.cameraPreviewView)
        return filter
    }()
    
    private var camera: GPUImageStillCamera?
    private var status: Status = .Preview
    private let screenSize = UIScreen.mainScreen().bounds
    private var currentPostRef: Firebase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCameraWithDevicePosition(.Back)
        
        self.captureButton.layer.cornerRadius = 32

        self.cameraStillView.layer.shadowColor = UIColor.blackColor().CGColor
        self.cameraStillView.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.cameraStillView.layer.shadowRadius = 16
        self.cameraStillView.layer.shadowOpacity = 0.33
        self.cameraStillView.layer.masksToBounds = false
        self.cameraStillView.layer.shouldRasterize = true
        
        self.cameraPreviewView.frame = self.cameraPreviewContainerView.bounds
        self.cameraPreviewContainerView.addSubview(self.cameraPreviewView)
        
        self.currentPostRef = self.selectedChannel?.createRefForNewPost()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.cameraTransitionView.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIView.animateWithDuration(0.5, animations: {
            self.cameraTransitionView.alpha = 0
        }, completion: { (value: Bool) in
                self.cameraTransitionView.hidden = true
        })
        self.camera?.startCameraCapture()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.camera?.stopCameraCapture()
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.camera?.outputImageOrientation = toInterfaceOrientation
    }
    
    override func viewDidLayoutSubviews() {
        self.cameraPreviewView.frame = self.cameraPreviewContainerView.bounds
    }
    
    func initializeCameraWithDevicePosition(devicePosition:AVCaptureDevicePosition) {
        if let camera = self.camera {
            camera.removeAllTargets()
            camera.stopCameraCapture()
        }
        
        self.camera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPresetPhoto, cameraPosition:devicePosition)
        self.camera?.outputImageOrientation = .Portrait // TODO: make this reflect device's current orientation
        self.camera?.addTarget(self.captureFilter)
        self.camera?.startCameraCapture()
    }

    // MARK: Button Actions
    @IBAction func dismissButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func switchCameraButtonDidTouch(sender: AnyObject) {
        var newPosition: AVCaptureDevicePosition = .Front
        if let position = self.camera?.cameraPosition() where position == .Front {
            newPosition = .Back
        }
        self.initializeCameraWithDevicePosition(newPosition)
    }
    
    @IBAction func captureFrame(sender: AnyObject) {
        if self.status == .Preview {
            captureButton.userInteractionEnabled = false
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.cameraPreviewView.alpha = 1.0;
                self.cameraOverlayView.alpha = 1
            })
            
            self.camera?.capturePhotoAsJPEGProcessedUpToFilter(self.captureFilter, withOrientation:UIImageOrientation(deviceOrientation:UIDevice.currentDevice().orientation), withCompletionHandler: { (processedJPEG, error) in
                if let _ = error {
                    self.status = .Error
                    return
                }
                
                let metadata = self.camera?.currentCaptureMetadata
                PostUploadManager.sharedManager().postPhotoFromData(processedJPEG, withExifAttachments: metadata, inChannel: self.selectedChannel, withPostRef: self.currentPostRef)
                
                self.cameraCaptureCheckMarkView.setupProperties()
                self.cameraCaptureCheckMarkView.setupLayers()
                self.cameraCaptureCheckMarkView.runFullAnimation()
                
                self.cameraStillView.image = UIImage(data: processedJPEG);
                self.cameraStillWidthConstraint.constant = 0
                self.view.layoutIfNeeded()
                
                UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseOut, animations: { () -> Void in
                    self.cameraStillView.alpha = 1
                    self.cameraStillWidthConstraint.constant = 96
                    self.view.layoutIfNeeded()
                }, completion: {(value: Bool) in
                    self.captureButton.userInteractionEnabled = true
                    
                    UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {
                        self.cameraStillView.alpha = 1.0;
                        self.cameraStillWidthConstraint.constant = -self.screenSize.width + 1
                        self.view.layoutIfNeeded()
                        self.cameraOverlayView.alpha = 0
                    }, completion: { (value: Bool) in
                        self.cameraStillView.alpha = 0
                    })
                })
                self.status = .Preview
            })
        } else if self.status == .Still || self.status == .Error {
            UIView.animateWithDuration(0.225, animations: { () -> Void in
                self.cameraStillView.alpha = 0.0;
                self.cameraPreviewView.alpha = 1.0;
                self.captureButton.setTitle("", forState: UIControlState.Normal)
            }, completion: { (done) -> Void in
                self.cameraStillView.image = nil;
            })
        }
    }
}