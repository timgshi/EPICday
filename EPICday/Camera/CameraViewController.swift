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
import FastttCamera

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
    

    private let screenSize = UIScreen.mainScreen().bounds
    private let orientationManager = IFTTTDeviceOrientation()
    private var cameraViewController = FastttFilterCamera(filterImage: UIImage(named: "CastilleroFilter"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.captureButton.layer.cornerRadius = 32

        self.cameraStillView.layer.shadowColor = UIColor.blackColor().CGColor
        self.cameraStillView.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.cameraStillView.layer.shadowRadius = 16
        self.cameraStillView.layer.shadowOpacity = 0.33
        self.cameraStillView.layer.masksToBounds = false
        self.cameraStillView.layer.shouldRasterize = true
        
        self.addCameraViewController()
        orientationManager.updateListener = self
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didRotateNotification), name: UIDeviceOrientationDidChangeNotification, object: nil)
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
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cameraViewController.view.frame = cameraPreviewContainerView.bounds
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    private func addCameraViewController() {
        cameraViewController.delegate = self
        cameraViewController.willMoveToParentViewController(self)
        cameraViewController.beginAppearanceTransition(true, animated: false)
        addChildViewController(cameraViewController)
        cameraPreviewContainerView.addSubview(cameraViewController.view)
        cameraViewController.endAppearanceTransition()
        cameraViewController.didMoveToParentViewController(self)
        
        // Need to set the filter once more, for some reason.
        cameraViewController.filterImage = UIImage(named: "CastilleroFilter")
    }
    
    func didRotateNotification (notification: NSNotification) {
        self.reconfigureButtonsForOrientation(UIDevice.currentDevice().orientation)
    }

    // MARK: Button Actions
    @IBAction func dismissButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func switchCameraButtonDidTouch(sender: AnyObject) {
        cameraViewController.cameraDevice = cameraViewController.cameraDevice == .Front ? .Rear : .Front
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
            self.cameraPreviewContainerView.alpha = 1.0;
            self.cameraOverlayView.alpha = 1
        })

        cameraViewController.takePicture()
    }
    
    func handleCapturedImage(image: UIImage) {
        self.runCaptureAnimationWithImage(image)
        self.uploadImageAsynchronously(image)
    }
    
    func uploadImageAsynchronously(image: UIImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let imageData = UIImageJPEGRepresentation(image, 0.7);
            PostUploadManager.sharedManager().postPhotoFromData(imageData, withSize: image.size, inChannel: self.selectedChannel)
        }
    }
    
    
    var animating = false
    //MARK: - Animation
    func reconfigureButtonsForOrientation(orientation: UIDeviceOrientation) {
        
        if animating {
            return
        }
        
        animating = true
        
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
        }, completion: { _ in
            self.animating = false
        })
    }
    
    func runCaptureAnimationWithImage(image: UIImage?) {
        
        if let image = image where image.imageOrientation != .Up,
            let cgImage = image.CGImage {
            self.cameraStillView.image = UIImage(CGImage: cgImage, scale: image.scale, orientation: .Up)
        } else {
            self.cameraStillView.image = image
        }
        
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

extension CameraViewController: FastttCameraDelegate {

    func cameraController(cameraController: FastttCameraInterface!, didFinishCapturingImage capturedImage: FastttCapturedImage!) {
        handleCapturedImage(capturedImage.fullImage)
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

extension CameraViewController: IFTTTDeviceOrientationUpdatable {
    
    func deviceOrientationDidChange(orientation: UIDeviceOrientation) {
        dispatch_async(dispatch_get_main_queue()) { 
            self.reconfigureButtonsForOrientation(orientation)
        }
    }
    
}