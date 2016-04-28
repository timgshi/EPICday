//
//  homeView.swift
//  dojo-custom-camera
//
//  Created by VIRAKRI JINANGKUL on 3/4/16.
//  Copyright © 2016 xmcdojo. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    
    var transition = QZCircleSegue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     cameraButton.layer.cornerRadius = 36
        cameraButton.layer.masksToBounds = false
        cameraButton.layer.shadowColor = UIColor.blackColor().CGColor
        cameraButton.layer.shadowOpacity = 0.5
        cameraButton.layer.shadowRadius = 12.0
        cameraButton.layer.shadowOffset = CGSize(width: 0, height: 12)
        
        //XMCCameraViewController.camera = XMCCamera(sender: self)
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueCamera") {
            /* Send the button to your transition manager */
            self.transition.animationChild = cameraButton
            /* Set the color to your transition manager*/
            self.transition.animationColor = UIColor(red: 0/255, green: 217/255, blue: 144/255, alpha: 1.0)
        }
        let toViewController = segue.destinationViewController as! XMCCameraViewController
        /* Set both, the origin and destination to your transition manager*/
        self.transition.fromViewController = self
        self.transition.toViewController = toViewController
        /* Add the transition manager to your transitioningDelegate View Controller*/
        toViewController.transitioningDelegate = transition
    }
    
    
}
