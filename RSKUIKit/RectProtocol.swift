//
// RectProtocol.swift
//
// Copyright (c) 2021 R.SK Lab Ltd. All Rights Reserved.
//
// Licensed under the RPL-1.5 and R.SK Lab Professional licenses
// (the "Licenses"); you may not use this work except in compliance
// with the Licenses. You may obtain a copy of the Licenses in
// the LICENSE_RPL and LICENSE_RSK_LAB_PROFESSIONAL files.
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the Licenses is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied.
//

import RSKCoreGraphics

/// The protocol to be adopted by a type of object that represents a rectangle in the upper-left-origin coordinate system.
public protocol RectProtocol: RSKCoreGraphics.RectProtocol {}

public extension RectProtocol {
    
    // MARK: - Public Properties
    
    /// An x-coordinate of the bottom edge of the rectangle.
    var bottom: CGFloat {
        
        get {
            
            self.y + self.height
        }
        set {
            
            if self.height > 0.0 {
                
                self.y = newValue - height
            }
            else {
                
                self.height = newValue - self.y
            }
        }
    }
    
    /// Largest value for the y-coordinate of the rectangle.
    var maxY: CGFloat {
        
        self.bottom
    }
    
    /// A y-coordinate of the top edge of the rectangle.
    var top: CGFloat {
        
        get {
            
            self.y
        }
        set {
            
            self.y = newValue
        }
    }
}
