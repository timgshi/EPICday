//
//  PhotoProvider.swift
//  EPICday
//
//  Created by Max Mamis on 4/28/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

import UIKit
import NYTPhotoViewer
import SDWebImage

class PhotoProvider: NSObject, NYTPhoto {
    var image: UIImage?
    
    init (photo: Photo, placeholder: UIImage?) {
        self.imageURL = photo.imageUrl
        self.placeholderImage = placeholder
        self.photo = photo
    }
    
    var photo: Photo
    private var imageURL: NSURL?
    var imageData: NSData? = nil
    var placeholderImage: UIImage? = nil
    var attributedCaptionTitle: NSAttributedString? = nil
    var attributedCaptionCredit: NSAttributedString? = nil
    var attributedCaptionSummary: NSAttributedString? = nil
    
    func load(completion: () -> Void) {
        guard let imageURL = imageURL else {
            return
        }
        
        SDWebImageManager.sharedManager().downloadImageWithURL(imageURL, options: [], progress: nil) { (image, _, _, _, _) in
            self.image = image
            completion()
        }
    }
}
