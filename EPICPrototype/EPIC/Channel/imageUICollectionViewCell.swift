//
//  imageUICollectionViewCell.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 2/21/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit

class imageUICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageGray: UIImageView!
    @IBOutlet weak var greenOverlay: UIView!
    
    @IBOutlet var greenDot: UIView!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var stolenSymbol: UIImageView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var cellWrapView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        author.attributedText = NSAttributedString(string: author.text!, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Left))
        author.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        author.layer.shadowOffset = CGSize(width: 0, height: 0)
        author.layer.shadowRadius = 4
        author.layer.shadowOpacity = 1
        author.layer.shouldRasterize = true;
        
        //
        
        timeAgoLabel.attributedText = NSAttributedString(string: timeAgoLabel.text!, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Right))
        timeAgoLabel.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        timeAgoLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        timeAgoLabel.layer.shadowRadius = 4
        timeAgoLabel.layer.shadowOpacity = 1
        timeAgoLabel.layer.shouldRasterize = true
        
        greenDot.layer.cornerRadius = 4
        greenDot.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        greenDot.layer.shadowOffset = CGSize(width: 0, height: 0)
        greenDot.layer.shadowRadius = 4
        greenDot.layer.shadowOpacity = 0.33
//        greenDot.layer.shouldRasterize = true
    }
    
    func convertToGrayScale(image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        CGContextDrawImage(context, imageRect, image.CGImage)
        let imageRef = CGBitmapContextCreateImage(context)
        let newImage = UIImage(CGImage: imageRef!)
        
        return newImage
    }
}
