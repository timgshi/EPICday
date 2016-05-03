//
//  UIImageOrientation+UIDeviceOrientation.swift
//  EPICday
//
//  Created by Max Mamis on 5/2/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

import Foundation
import UIKit

extension UIImageOrientation {
    init(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .PortraitUpsideDown:
            self = .Down
        case .LandscapeLeft:
            self = .Left
        case .LandscapeRight:
            self = .Right
        default:
            self = .Up
        }
    }
}