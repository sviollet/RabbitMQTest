//
//  UIView+CornerRadius.swift
//  Alarm
//
//  Created by samuel on 03/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
