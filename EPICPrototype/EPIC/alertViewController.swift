//
//  alertViewController.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 3/5/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit

class alertViewController : UIViewController {
    
    var alertHeaderString : String = "The #montues channel"
    var alertBodyString : String = "We got you things started for you. You’re now in the official #montues channel. Get started by adding your photos."
    var alertActionButtonString : String = "OK, GOT IT!"
    
    @IBOutlet weak var alertModalViewBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var alertModalView: UIView!
    @IBOutlet weak var overlayView: UIView!

    @IBOutlet weak var alertHeader: UILabel!
    
    @IBOutlet weak var alertBody: UILabel!
    
    @IBOutlet weak var alertActionButton: UIButton!
    @IBAction func alertActionButtonDidTouch(sender: AnyObject) {
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alertModalViewBottomContraint.constant = -self.alertModalView.frame.height
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIApplication.sharedApplication().sendAction("maximizeView:", to: nil, from: self, forEvent: nil)
        
        UIView.animateWithDuration(0.5, animations: {self.overlayView.alpha = 0
            }, completion: {
            (value : Bool) in
                self.dismissViewControllerAnimated(false, completion: nil)
        })
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        alertHeader.attributedText = NSAttributedString(string: alertHeaderString, attributes: NSDictionary.headerMediumAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Center))
        alertBody.attributedText = NSAttributedString(string: alertBodyString, attributes: NSDictionary.bodyMediumAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Center))
        alertActionButton.setAttributedTitle(NSAttributedString(string: alertActionButtonString, attributes:  NSDictionary.callToActionButtonAttributes(UIColor.colorEpicWhite())), forState: .Normal)
        
    }

    override func viewWillAppear(animated: Bool) {
        

    }
    
    override func viewDidAppear(animated: Bool) {

        self.alertModalViewBottomContraint.constant = -self.alertModalView.frame.height
        self.view.layoutIfNeeded()
        view.bringSubviewToFront(alertModalView)
        
        UIView.animateWithDuration(0.5, animations: {
        
            self.overlayView.alpha = 1
            
        })
        
        UIView.animateWithDuration(0.2, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alertModalView.hidden = false
            self.alertModalViewBottomContraint.constant = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
        

        
        
        
        UIApplication.sharedApplication().sendAction("minimizeView:", to: nil, from: self, forEvent: nil)

    }
    
}
