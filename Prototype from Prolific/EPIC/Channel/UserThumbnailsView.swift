//
//  UserThumbnailsView.swift
//  EPIC
//
//  Created by Prolific Interactive on 2/22/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit
import QuartzCore
import WebImage

public final class UserThumbnailsView: UIView {
    
    @IBInspectable
    var maxShowThumb: Int = 0
    
    @IBInspectable
    var beginSpace: CGFloat = 8
    
    @IBInspectable
    var space:CGFloat = 24
    
    @IBInspectable
    var shadowRadius: CGFloat = 2.0
    
    @IBInspectable
    var borderSize: CGFloat = 2.0

    var leadingThumbs = [NSLayoutConstraint]()
    
    var usersThumbURLs: [NSURL]? {
        didSet {
            // Prepare
            subviews.forEach {
                $0.removeFromSuperview()
            }
            leadingThumbs.removeAll()
            prepareViews()
            // Start animate?
        }
    }

    func prepareViews() {
        var lastView: ThumbView?
        let height = frame.height
        
        
        var maxItem: Int = 0
        if let _ = usersThumbURLs {
            let lastSpace = frame.width - frame.height
            if lastSpace > 0 {
                maxItem = Int(lastSpace / space) + 1
                if maxShowThumb > 0 {
                    maxItem = min(maxItem, maxShowThumb)
                }
            }
        }
        
        var count = 0
        guard let usersThumbURLs = usersThumbURLs else {
            return
        }
        
        for imageURL in usersThumbURLs {
            var needToExit = false
            
            var view: ThumbView!
            ++count
            if count > maxItem - 1  && (usersThumbURLs.count - count != 0){
                let v = LabelThumbView(frame: CGRect(origin: CGPointZero, size: CGSize(width: height, height: height)),shadowRadius: shadowRadius,borderSize: borderSize)
                v.titleLabel.text = "\(usersThumbURLs.count - count + 1)"
                needToExit = true
                view = v
            }else{
                let v = ImageThumbView(frame: CGRect(origin: CGPointZero, size: CGSize(width: height, height: height)),shadowRadius: shadowRadius,borderSize: borderSize)
                v.imageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage(), options: [.ProgressiveDownload,.TransformAnimatedImage])
                view = v
            }

            view.translatesAutoresizingMaskIntoConstraints = false
            
            var leading: NSLayoutConstraint!
            
            if let lastView = lastView {
                leading = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: lastView, attribute: .Leading, multiplier: 1, constant: CGFloat(leadingThumbs.count + 1) * beginSpace)
            }else{
                leading = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: beginSpace)
            }
            
            leadingThumbs.append(leading)
            
            let horizontal = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
            let ratio = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: 0)
            
            view.alpha = 0
            
            addSubview(view)
            
            addConstraints([leading,horizontal,ratio,height])
            
            lastView = view
            
            if needToExit {
                break
            }

        }
        
        layoutIfNeeded()
        
//        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseOut, animations: {
            var i = 0
            self.leadingThumbs.forEach{
                print(self.leadingThumbs.indexOf($0)!)
                if self.leadingThumbs.indexOf($0) == 0 {
                    //$0.constant = -self.shadowRadius
                    UIView.animateWithDuration(0.2, delay: Double(i) * 0.05, options: .CurveEaseOut, animations: {
                        self.leadingThumbs[i].constant = -self.shadowRadius
                        self.subviews[i].alpha = 1
                        self.layoutIfNeeded()
                    }, completion: nil)
                }else{
                    //$0.constant = self.space
                    UIView.animateWithDuration(0.2, delay: Double(i) * 0.05, options: .CurveEaseOut, animations: {
                        self.leadingThumbs[i].constant = self.space
                        self.subviews[i].alpha = 1
                        self.layoutIfNeeded()
                        }, completion: nil)
                }
                i++
            }
            
//            self.subviews.forEach {
//                $0.alpha = 1
//            }
//            self.layoutIfNeeded()
//        }, completion: nil)
        



    }
}

