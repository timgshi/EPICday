//
//  XMCCameraViewController.swift
//  dojo-custom-camera
//
//  Created by David McGraw on 11/13/14.
//  Copyright (c) 2014 David McGraw. All rights reserved.
//

import UIKit
import AVFoundation

enum Status: Int {
    case Preview, Still, Error
}

class XMCCameraViewController: UIViewController, XMCCameraDelegate {

    @IBOutlet weak var cameraStill: UIImageView!
    @IBOutlet weak var cameraPreview: UIView!

    @IBOutlet weak var cameraCapture: UIButton!
   
    
    @IBOutlet weak var cameraTransitionInView: UIView!
    @IBOutlet weak var cameraOverlayView: UIView!
    @IBOutlet weak var cameraStillContraintWidth: NSLayoutConstraint!
    @IBOutlet weak var cameraCaptureBorder: checkMarkView!
    var preview: AVCaptureVideoPreviewLayer?
    
    var camera: XMCCamera?
    var cameraFront: XMCCameraFront?
    var status: Status = .Preview
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCamera()
        self.cameraCapture.layer.cornerRadius = 32
//        self.cameraCaptureBorder.layer.cornerRadius = 32 + 7
//        self.cameraCaptureBorder.layer.borderColor = UIColor.whiteColor().CGColor
//        self.cameraCaptureBorder.layer.borderWidth = 3
        
        
        self.cameraStill.layer.shadowColor = UIColor.blackColor().CGColor
        self.cameraStill.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.cameraStill.layer.shadowRadius = 16
        self.cameraStill.layer.shadowOpacity = 0.33
        self.cameraStill.layer.masksToBounds = false
        self.cameraStill.layer.shouldRasterize = true
        self.cameraTransitionInView.alpha = 1
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.establishVideoPreviewArea((self.camera?.session)!)
        
        self.cameraTransitionInView.hidden = false
    }
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIView.animateWithDuration(0.5, animations: {
            self.cameraTransitionInView.alpha = 0
            }, completion: {
        (value: Bool) in
        
                self.cameraTransitionInView.hidden = true
        })
    }
    
    func initializeCamera() {
//        self.cameraStatus.text = "Starting Camera"
        self.camera = XMCCamera(sender: self)
//        self.cameraFront = XMCCameraFront(sender: self)
    }
    
    func establishVideoPreviewArea(getSession: AVCaptureSession) {
        self.preview = AVCaptureVideoPreviewLayer(session: getSession)
        self.preview?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.preview?.frame = self.cameraPreview.bounds
        self.preview?.cornerRadius = 0
        self.cameraPreview.layer.addSublayer(self.preview!)
    }
    
    // MARK: Button Actions
    
    @IBAction func dismissButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func switchCameraButtonDidTouch(sender: AnyObject) {
        

        if self.cameraFront == nil {
            self.cameraFront = XMCCameraFront(sender: self)
            self.establishVideoPreviewArea((self.cameraFront?.session)!)
            self.camera = nil
        }
        else{
            self.camera = XMCCamera(sender: self)
            self.establishVideoPreviewArea((self.camera?.session)!)
            self.cameraFront = nil
        }
        
//        self.establishVideoPreviewArea((self.camera?.session)!)
        
    }
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    
    
    @IBAction func captureFrame(sender: AnyObject) {
        if self.status == .Preview {
            cameraCapture.userInteractionEnabled = false
            //self.cameraStatus.text = "Capturing Photo"
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.cameraPreview.alpha = 1.0;
//                self.cameraStatus.alpha = 1.0
                self.cameraOverlayView.alpha = 1
            })
            
            
            if self.cameraFront == nil {
                self.camera?.captureStillImage({ (image) -> Void in
                    if image != nil {
                        self.cameraCaptureBorder.setupProperties()
                        self.cameraCaptureBorder.setupLayers()
                        self.cameraCaptureBorder.addStartCheckmarkAnimationCompletionBlock({
                            (value: Bool) in
                            
                            self.cameraCaptureBorder.addEndCheckmarkAnimationCompletionBlock({
                                (value: Bool) in
                                
                            })
                            
                        })
                        
                        self.cameraStill.image = image;
                        self.cameraStillContraintWidth.constant = 0
                        self.view.layoutIfNeeded()
                        //self.cameraStill.transform = CGAffineTransformMakeScale(1, 1)
                        
                        UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseOut, animations: { () -> Void in
                            self.cameraStill.alpha = 1
                            self.cameraStillContraintWidth.constant = 96
                            self.view.layoutIfNeeded()
                            //                        self.cameraOverlayView.alpha = 0.5
                            
                            //self.cameraStill.transform = CGAffineTransformMakeScale(0, 0)
                            }, completion: {
                                (value: Bool) in
                                self.cameraCapture.userInteractionEnabled = true
                                UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {
                                    self.cameraStill.alpha = 1.0;
                                    //                                self.cameraStatus.alpha = 0.0;
                                    self.cameraStillContraintWidth.constant = -self.screenSize.width + 1
                                    self.view.layoutIfNeeded()
                                    self.cameraOverlayView.alpha = 0
                                    }, completion: {
                                        (value: Bool) in
                                        self.cameraStill.alpha = 0
                                })
                                
                                
                        })
                        self.status = .Preview
                    } else {
                        //                    self.cameraStatus.text = "Uh oh! Something went wrong. Try it again."
                        self.status = .Error
                    }
                    
                    //                self.cameraCapture.setTitle("", forState: UIControlState.Normal)
                })

            }
            else{
                self.cameraFront?.captureStillImage({ (image) -> Void in
                    let flipImage:UIImage = UIImage(CGImage: image!.CGImage!, scale: 1.0, orientation: .LeftMirrored)
                    if image != nil {
                        self.cameraCaptureBorder.setupProperties()
                        self.cameraCaptureBorder.setupLayers()
                        self.cameraCaptureBorder.addStartCheckmarkAnimationCompletionBlock({
                            (value: Bool) in
                            
                            self.cameraCaptureBorder.addEndCheckmarkAnimationCompletionBlock({
                                (value: Bool) in
                                
                            })
                            
                        })
                        
                        self.cameraStill.image = flipImage;
                        self.cameraStillContraintWidth.constant = 0
                        self.view.layoutIfNeeded()
                        //self.cameraStill.transform = CGAffineTransformMakeScale(1, 1)
                        
                        UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseOut, animations: { () -> Void in
                            self.cameraStill.alpha = 1
                            self.cameraStillContraintWidth.constant = 96
                            self.view.layoutIfNeeded()
                            //                        self.cameraOverlayView.alpha = 0.5
                            
                            //self.cameraStill.transform = CGAffineTransformMakeScale(0, 0)
                            }, completion: {
                                (value: Bool) in
                                self.cameraCapture.userInteractionEnabled = true
                                UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {
                                    self.cameraStill.alpha = 1.0;
                                    //                                self.cameraStatus.alpha = 0.0;
                                    self.cameraStillContraintWidth.constant = -self.screenSize.width + 1
                                    self.view.layoutIfNeeded()
                                    self.cameraOverlayView.alpha = 0
                                    }, completion: {
                                        (value: Bool) in
                                        self.cameraStill.alpha = 0
                                })
                                
                                
                        })
                        self.status = .Preview
                    } else {
                        //                    self.cameraStatus.text = "Uh oh! Something went wrong. Try it again."
                        self.status = .Error
                    }
                    
                    //                self.cameraCapture.setTitle("", forState: UIControlState.Normal)
                })

            }
            
            
                    } else if self.status == .Still || self.status == .Error {
            UIView.animateWithDuration(0.225, animations: { () -> Void in
                self.cameraStill.alpha = 0.0;
//                self.cameraStatus.alpha = 0.0;
                self.cameraPreview.alpha = 1.0;
                self.cameraCapture.setTitle("", forState: UIControlState.Normal)
                
                
            }, completion: { (done) -> Void in
                self.cameraStill.image = nil;
                self.status = .Preview
            })
        }
    }
    
    // MARK: Camera Delegate
    
    func cameraSessionConfigurationDidComplete() {
        self.camera?.startCamera()
        self.cameraFront?.startCamera()
    }
    
    func cameraSessionDidBegin() {
//        self.cameraStatus.text = ""
        UIView.animateWithDuration(0.225, animations: { () -> Void in
//            self.cameraStatus.alpha = 0.0
            self.cameraPreview.alpha = 1.0
            self.cameraCapture.alpha = 1.0
            self.cameraTransitionInView.alpha = 0
//            self.cameraCaptureShadow.alpha = 0.4;
        })
    }
    
    func cameraSessionDidStop() {
//        self.cameraStatus.text = "Camera Stopped"
        UIView.animateWithDuration(0.225, animations: { () -> Void in
//            self.cameraStatus.alpha = 1.0
            self.cameraPreview.alpha = 0.0
            
        })
    }
}

