//
//  HighlightTintButton.swift
//  EPICday
//
//  Created by Max Mamis on 5/4/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

import UIKit

@IBDesignable class HighlightTintButton: UIButton {
    @IBInspectable var highlightTintColor: UIColor?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if let tintColor = highlightTintColor {
            
            if self.imageView?.image?.renderingMode != .AlwaysTemplate {
                self.imageView?.image = self.imageView?.image?.imageWithRenderingMode(.AlwaysTemplate)
            }
            
            self.imageView?.tintColor = tintColor
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        self.imageView?.tintColor = nil
    }
}