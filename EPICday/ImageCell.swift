//
//  imageUICollectionViewCell.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 2/21/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit
import FormatterKit
import SDWebImage

protocol ImageCellDelegate: class {
    func imageCellDidLongPress(cell: ImageCell)
}

class ImageCell: UICollectionViewCell {
    weak var delegate: ImageCellDelegate?
        static let timeAgoFormatter = TTTTimeIntervalFormatter()
    
    var cellDidTapBlock: (ImageCell -> Void)?
    var cellDidLongPressBlock: (ImageCell -> Void)?
    
    var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    var photo: Photo?
    
    var thumbnailURL: NSURL? {
        didSet {
            self.imageView.sd_setImageWithURL(thumbnailURL)
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet private weak var timeAgoLabel: UILabel!
    @IBOutlet private weak var wrapperView: UIView!
    @IBOutlet private weak var stolenOverlayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        authorLabel.attributedText = NSAttributedString(string: authorLabel.text!, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Left))
        authorLabel.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        authorLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        authorLabel.layer.shadowRadius = 4
        authorLabel.layer.shadowOpacity = 1
        authorLabel.layer.shouldRasterize = true;
        authorLabel.text = ""
        
        
        timeAgoLabel.attributedText = NSAttributedString(string: timeAgoLabel.text!, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Right))
        timeAgoLabel.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        timeAgoLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        timeAgoLabel.layer.shadowRadius = 4
        timeAgoLabel.layer.shadowOpacity = 1
        timeAgoLabel.layer.shouldRasterize = true;
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleTapGR))
        self.contentView.addGestureRecognizer(tapGR)
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGR))
        self.contentView.addGestureRecognizer(longPressGR)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = ""
        timeAgoLabel.text = ""
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
        photo = nil
        self.cellDidTapBlock = nil
        self.cellDidLongPressBlock = nil
    }
    
    func setTimeAgoTextFromDate(date: NSDate!) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            let timeAgoText = ImageCell.timeAgoFormatter.stringForTimeIntervalFromDate(NSDate(), toDate: date)
            dispatch_async(dispatch_get_main_queue(), { 
                self.timeAgoLabel.text = timeAgoText
            })
        }
    }
    @IBAction func handleTapGR(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            if let block = cellDidTapBlock {
                block(self)
            }
        }
    }
    
    @IBAction func handleLongPressGR(sender: UILongPressGestureRecognizer) {
        UIView.animateWithDuration(0.05, delay: 0, options: .CurveLinear, animations: {
            self.wrapperView.transform = CGAffineTransformMakeScale(0.888, 0.888)
            self.stolenOverlayView.alpha = 1
        }, completion: nil )
        
        if sender.state == .Ended {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 15, options: .CurveLinear , animations: {
                self.wrapperView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
            UIView.animateWithDuration(1, animations: {
                
                self.stolenOverlayView.alpha = 0
            })
            
            self.delegate?.imageCellDidLongPress(self)
        }
    }
}
