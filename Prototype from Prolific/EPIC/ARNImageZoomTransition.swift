//
//  ARNImageZoomTransition.swift
//  ARNZoomImageTransition
//
//  Created by xxxAIRINxxx on 2015/08/08.
//  Copyright (c) 2015 xxxAIRINxxx. All rights reserved.
//

import UIKit
import ARNTransitionAnimator

@objc protocol ARNImageTransitionZoomable {
    
    func createTransitionImageView() -> UIImageView
    
    // Present, Push
    
    optional
    func presentationBeforeAction()
    
    optional
    func presentationAnimationAction(percentComplete: CGFloat)
    
    optional
    func presentationCancelAnimationAction()
    
    optional
    func presentationCompletionAction(completeTransition: Bool)
    
    // Dismiss, Pop
    
    optional
    func dismissalBeforeAction()
    
    optional
    func dismissalAnimationAction(percentComplete: CGFloat)
    
    optional
    func dismissalCancelAnimationAction()
    
    optional
    func dismissalCompletionAction(completeTransition: Bool)
}

class ARNImageZoomTransition {
    
    class func createAnimator(operationType: ARNTransitionAnimatorOperation, fromVC: UIViewController, toVC: UIViewController) -> ARNTransitionAnimator {
        let animator = ARNTransitionAnimator(operationType: operationType, fromVC: fromVC, toVC: toVC)
        
        if let sourceTransition = fromVC as? ARNImageTransitionZoomable, let destinationTransition = toVC as? ARNImageTransitionZoomable {
            
            animator.presentationBeforeHandler = { [weak fromVC, weak toVC
                , weak sourceTransition, weak destinationTransition](containerView: UIView, transitionContext: UIViewControllerContextTransitioning) in
                containerView.addSubview(fromVC!.view)
                containerView.addSubview(toVC!.view)
                
                toVC!.view.layoutSubviews()
                toVC!.view.layoutIfNeeded()
                
                let sourceImageView = sourceTransition!.createTransitionImageView()
                let destinationImageView = destinationTransition!.createTransitionImageView()
                
                containerView.addSubview(sourceImageView)
                
                sourceTransition!.presentationBeforeAction?()
                destinationTransition!.presentationBeforeAction?()
                
                toVC!.view.alpha = 0.0
                
                animator.presentationAnimationHandler = { (containerView: UIView, percentComplete: CGFloat) in
                    sourceImageView.frame = destinationImageView.frame
                    
                    toVC!.view.alpha = 1.0
                    
                    sourceTransition!.presentationAnimationAction?(percentComplete)
                    destinationTransition!.presentationAnimationAction?(percentComplete)
                }
                
                animator.presentationCompletionHandler = { (containerView: UIView, completeTransition: Bool) in
                    sourceImageView.removeFromSuperview()
                    
                    sourceTransition!.presentationCompletionAction?(completeTransition)
                    destinationTransition!.presentationCompletionAction?(completeTransition)
                }
            }
            
            animator.dismissalBeforeHandler = { [weak fromVC, weak toVC
                , weak sourceTransition, weak destinationTransition] (containerView: UIView, transitionContext: UIViewControllerContextTransitioning) in
                containerView.addSubview(toVC!.view)
                containerView.bringSubviewToFront(fromVC!.view)
                
                let sourceImageView = sourceTransition!.createTransitionImageView()
                let destinationImageView = destinationTransition!.createTransitionImageView()
                containerView.addSubview(sourceImageView)
                
                sourceTransition!.dismissalBeforeAction?()
                destinationTransition!.dismissalBeforeAction?()
                
                animator.dismissalAnimationHandler = { (containerView: UIView, percentComplete: CGFloat) in
                    sourceImageView.frame = destinationImageView.frame
                    fromVC!.view.alpha = 0.0
                    
                    sourceTransition!.dismissalAnimationAction?(percentComplete)
                    destinationTransition!.dismissalAnimationAction?(percentComplete)
                }
                
                animator.dismissalCompletionHandler = { (containerView: UIView, completeTransition: Bool) in
                    sourceImageView.removeFromSuperview()
                    
                    sourceTransition!.dismissalCompletionAction?(completeTransition)
                    destinationTransition!.dismissalCompletionAction?(completeTransition)
                }
            }
        }
        
        return animator
    }
}
