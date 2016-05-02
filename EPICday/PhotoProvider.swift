//
//  PhotoProvider.swift
//  EPICday
//
//  Created by Max Mamis on 4/28/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

import UIKit
import NYTPhotoViewer

class PhotoProvider: NSObject, NYTPhoto {
    var image: UIImage?
    
    init (image: UIImage?) {
        self.image = image
    }
    
    var imageData: NSData? = nil
    var placeholderImage: UIImage? = nil
    var attributedCaptionTitle: NSAttributedString? = nil
    var attributedCaptionCredit: NSAttributedString? = nil
    var attributedCaptionSummary: NSAttributedString? = nil
}
