//
//  selectedImageViewController.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 3/5/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//


import UIKit

class selectedImageViewController : ARNModalImageTransitionViewController, ARNImageTransitionZoomable  {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var overlayView: UIView!

    @IBAction func exitDidTouch(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    
    
    }
    deinit {
        print("deinit ModalViewController")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("ModalViewController viewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("ModalViewController viewWillDisappear")
    }
    
        // MARK: - ARNImageTransitionZoomable
    
    
    func createTransitionImageView() -> UIImageView {
        let imageView = UIImageView(image: self.imageView.image)
        imageView.contentMode = self.imageView.contentMode
        imageView.clipsToBounds = true
        imageView.userInteractionEnabled = false
        imageView.frame = self.imageView!.frame
        return imageView
    }
    
    func presentationBeforeAction() {
        self.imageView.hidden = true
    }
    
    func presentationCompletionAction(completeTransition: Bool) {
        self.imageView.hidden = false
    }
    
    func dismissalBeforeAction() {
        self.imageView.hidden = true
    }
    
    func dismissalCompletionAction(completeTransition: Bool) {
        if !completeTransition {
            self.imageView.hidden = false
        }
    }
    
    
}