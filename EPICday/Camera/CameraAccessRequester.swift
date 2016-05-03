//
//  CameraAccessRequester.swift
//  EPICday
//
//  Created by Max Mamis on 5/2/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraAccessRequester {
    
    func runWithCameraAccessRequestIfNecessary(completion: (authorized: Bool) -> Void) {
        let currentStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch currentStatus {
        case .Authorized:
            completion(authorized: true)
            break
        case .NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: completion)
            break
        default:
            completion(authorized: false)
        }
    }
    
}