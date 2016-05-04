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

class CameraViewController: UIViewController {
    
    var selectedChannel: Channel?
    
    @IBOutlet private weak var cameraStillView: UIImageView!
    @IBOutlet private weak var cameraPreviewContainerView: UIView!
    @IBOutlet private weak var captureButton: UIButton!
    @IBOutlet private weak var cameraTransitionView: UIView!
    @IBOutlet private weak var cameraOverlayView: UIView!
    @IBOutlet private weak var cameraStillWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var cameraCaptureCheckMarkView: CheckMarkView!
    @IBOutlet private weak var switchCameraButton: UIButton!
    @IBOutlet private weak var pickFromLibraryButton: UIButton!
    
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
    private let screenSize = UIScreen.mainScreen().bounds

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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didRotateNotification), name: UIDeviceOrientationDidChangeNotification, object: nil)
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
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func shouldAutorotate() -> Bool {
        return false
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
    
    func didRotateNotification (notification: NSNotification) {
        self.reconfigureButtonsForOrientation(UIDevice.currentDevice().orientation)
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
    
    @IBAction func chooseFromLibraryTapped(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func captureFrame(sender: AnyObject) {
        captureButton.userInteractionEnabled = false
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.cameraPreviewView.alpha = 1.0;
            self.cameraOverlayView.alpha = 1
        })

        self.camera?.capturePhotoAsImageProcessedUpToFilter(self.captureFilter, withOrientation:UIImageOrientation(deviceOrientation:UIDevice.currentDevice().orientation), withCompletionHandler: { (processedImage, error) in
            if let _ = error {
                self.cameraOverlayView.alpha = 0
                return
            }
            self.runCaptureAnimationWithImage(processedImage)
            self.uploadImageAsynchronously(processedImage)
        })
    }
    
    func  uploadImageAsynchronously(image: UIImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let imageData = UIImageJPEGRepresentation(image, 0.7);
            PostUploadManager.sharedManager().postPhotoFromData(imageData, withSize: image.size, inChannel: self.selectedChannel)
        }
    }
    
    //MARK: - Animation
    func reconfigureButtonsForOrientation(orientation: UIDeviceOrientation) {
        var angle: CGFloat = 0.0;
        
        switch orientation {
        case .LandscapeLeft:
            angle = CGFloat(M_PI) / 2
            break
        case .LandscapeRight:
            angle = CGFloat(M_PI) / -2
            break
        case .PortraitUpsideDown:
            angle = CGFloat(M_PI)
            break
        default:
            break
        }
        
        UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .CurveEaseInOut, animations: {
            self.switchCameraButton.transform = CGAffineTransformMakeRotation(angle)
            self.pickFromLibraryButton.transform = CGAffineTransformMakeRotation(angle)
        }, completion: nil)
    }
    
    func runCaptureAnimationWithImage(image: UIImage) {
        self.cameraStillView.image = image;
        
        self.cameraStillWidthConstraint.constant = 0
        self.view.layoutIfNeeded()
        
        self.cameraCaptureCheckMarkView.setupProperties()
        self.cameraCaptureCheckMarkView.setupLayers()
        self.cameraCaptureCheckMarkView.runFullAnimation()
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: {
            self.cameraOverlayView.alpha = 0
        }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.cameraStillView.alpha = 1
            self.cameraStillWidthConstraint.constant = 96
            self.view.layoutIfNeeded()
        }, completion: {(value: Bool) in
        
            self.captureButton.userInteractionEnabled = true
                
            UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {
                self.cameraStillView.alpha = 1.0;
                self.cameraStillWidthConstraint.constant = -self.screenSize.width + 1
                self.view.layoutIfNeeded()
            }, completion: { (value: Bool) in
                self.cameraStillView.alpha = 0
            })
        })
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            data = UIImageJPEGRepresentation(image, 0.7) else {
            return
        }
        
        PostUploadManager.sharedManager().postPhotosFromUnfilteredGalleryImageAsData([data], inSelectedChannel: self.selectedChannel)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
