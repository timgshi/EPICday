//
//  ThumbView.swift
//  EPIC
//
//  Created by Prolific Interactive on 2/22/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit

public class ThumbView: UIView {
    
    var shadowRadius: CGFloat = 2
    
    var borderSize: CGFloat = 2
    
    var roundView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    init(frame: CGRect,shadowRadius: CGFloat,borderSize: CGFloat) {
        super.init(frame: frame)
        self.shadowRadius = shadowRadius
        self.borderSize = borderSize
        setupImageView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    func setupImageView() {
        backgroundColor = UIColor.clearColor()
        roundView = UIView(frame: CGRect(
            origin: CGPoint(x: shadowRadius, y: shadowRadius),
            size: CGSize(width: frame.width - (2 * shadowRadius), height: frame.height - (2 * shadowRadius))))
        roundView.backgroundColor = UIColor.colorEpicWhite()
        roundView.clipsToBounds = true
        
        addSubview(roundView)
        var _constraints = [NSLayoutConstraint]()
        roundView.translatesAutoresizingMaskIntoConstraints = false
        
        [NSLayoutAttribute.Top,NSLayoutAttribute.Leading].forEach {
            _constraints.append(NSLayoutConstraint(item: roundView, attribute: $0, relatedBy: .Equal, toItem: self, attribute: $0, multiplier: 1.0, constant: shadowRadius))
        }
        
        [NSLayoutAttribute.Bottom,NSLayoutAttribute.Trailing].forEach {
            _constraints.append(NSLayoutConstraint(item: self, attribute: $0, relatedBy: .Equal, toItem: roundView, attribute: $0, multiplier: 1.0, constant: shadowRadius))
        }
        
        addConstraints(_constraints)
        
    }
    
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = rect.width / 2
        roundView.layer.cornerRadius = layer.cornerRadius - shadowRadius
        roundView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.colorEpicBlack().CGColor
        layer.shadowPath = UIBezierPath(roundedRect: roundView.frame, cornerRadius: roundView.layer.cornerRadius).CGPath
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        
    }
    
}

final class ImageThumbView: ThumbView {
    
    var imageView: UIImageView!
    
    override func setupImageView() {
        super.setupImageView()
        
        imageView = UIImageView(frame: CGRect(
            origin: CGPoint(x: borderSize, y: borderSize),
            size: CGSize(width: roundView.frame.width - (2 * borderSize), height: roundView.frame.height - (2 * borderSize))))
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "image001")
        imageView.clipsToBounds = true
        
        roundView.addSubview(imageView)
        var _constraints = [NSLayoutConstraint]()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        [NSLayoutAttribute.Top,NSLayoutAttribute.Leading].forEach {
            _constraints.append(NSLayoutConstraint(item: imageView, attribute: $0, relatedBy: .Equal, toItem: roundView, attribute: $0, multiplier: 1.0, constant: borderSize))
        }
        
        [NSLayoutAttribute.Bottom,NSLayoutAttribute.Trailing].forEach {
            _constraints.append(NSLayoutConstraint(item: roundView, attribute: $0, relatedBy: .Equal, toItem: imageView, attribute: $0, multiplier: 1.0, constant: borderSize))
        }
        roundView.addConstraints(_constraints)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        imageView.layer.cornerRadius = roundView.layer.cornerRadius - borderSize
    }
}

final class LabelThumbView: ThumbView {
    
    var titleLabel: UILabel!
    
    override func setupImageView() {
        super.setupImageView()
        
        titleLabel = UILabel(frame: CGRect(
            origin: CGPoint(x: borderSize, y: borderSize),
            size: CGSize(width: roundView.frame.width , height: roundView.frame.height)))

        
        titleLabel.clipsToBounds = true
        titleLabel.backgroundColor = UIColor.colorEpicBlack()
        titleLabel.textColor = UIColor.colorEpicWhite()

        if let font  = UIFont(name: "FuturaLT-Bold", size: 14) {
            titleLabel.font = font
        }
        titleLabel.textAlignment = .Center
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        
        
        roundView.addSubview(titleLabel)
        var _constraints = [NSLayoutConstraint]()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [NSLayoutAttribute.Top,NSLayoutAttribute.Leading].forEach {
            _constraints.append(NSLayoutConstraint(item: titleLabel, attribute: $0, relatedBy: .Equal, toItem: roundView, attribute: $0, multiplier: 1.0, constant: 0))
        }
        
        [NSLayoutAttribute.Bottom,NSLayoutAttribute.Trailing].forEach {
            _constraints.append(NSLayoutConstraint(item: roundView, attribute: $0, relatedBy: .Equal, toItem: titleLabel, attribute: $0, multiplier: 1.0, constant: 0))
        }
        roundView.addConstraints(_constraints)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        titleLabel.layer.cornerRadius = (rect.width / 2) - borderSize - shadowRadius
    }
}

