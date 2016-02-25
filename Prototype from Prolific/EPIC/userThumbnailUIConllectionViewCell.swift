//
//  imageUICollectionViewCell.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 2/21/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit

class userThumbnailUIConllectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var borderStyle: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.layer.cornerRadius = 16
        borderStyle.layer.cornerRadius = 18
        borderStyle.layer.shadowColor = UIColor.colorEpicBlack().CGColor
        borderStyle.layer.shadowOffset = CGSize(width: 0, height: 2)
        borderStyle.layer.shadowRadius = 4
        borderStyle.layer.shadowOpacity = 0.2
        

    }
}
