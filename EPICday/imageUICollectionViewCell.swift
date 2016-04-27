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

class imageUICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var cellWrapView: UIView!
    
    static let timeAgoFormatter = TTTTimeIntervalFormatter()
    
    var cellDidTapBlock: (imageUICollectionViewCell -> Void)?
    var cellDidLongPressBlock: (imageUICollectionViewCell -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        author.attributedText = NSAttributedString(string: author.text!, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Left))
        author.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        author.layer.shadowOffset = CGSize(width: 0, height: 0)
        author.layer.shadowRadius = 4
        author.layer.shadowOpacity = 1
        author.layer.shouldRasterize = true;
        author.text = ""
        
        //
        
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
        author.text = ""
        timeAgoLabel.text = ""
        image.sd_cancelCurrentImageLoad()
        image.image = nil
        self.cellDidTapBlock = nil
        self.cellDidLongPressBlock = nil
    }
    
    func setTimeAgoTextFromDate(date: NSDate!) {
        let timeAgoText = imageUICollectionViewCell.timeAgoFormatter.stringForTimeIntervalFromDate(NSDate(), toDate: date)
        self.timeAgoLabel.text = timeAgoText
    }
    @IBAction func handleTapGR(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            if let block = cellDidTapBlock {
                block(self)
            }
        }
    }
    
    @IBAction func handleLongPressGR(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began  {
            if let block = self.cellDidLongPressBlock {
                block(self)
            }
        }
    }
    
}
