//
//  AllUserDelegateController.swift
//  EPIC
//
//  Created by Prolific Interactive on 2/22/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit

class AllUserDelegateController: NSObject, UICollectionViewDelegate {
    
    weak var imageChannelViewController: ImageChannelViewController?
    
    init(vc: ImageChannelViewController?) {
        self.imageChannelViewController = vc
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(__FUNCTION__ + indexPath.description)
    }
}
