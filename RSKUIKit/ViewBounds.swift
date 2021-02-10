//
// ViewBounds.swift
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

import CoreGraphics

/// The type of object that represents bounds of the view.
public struct ViewBounds: RectProtocol {
    
    // MARK: - Public Properties
    
    public var height: CGFloat
    
    public var width: CGFloat
    
    public var x: CGFloat
    
    public var y: CGFloat
    
    // MARK: - Public Initializers
    
    public init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        
        self.height = height
        self.width = width
        self.x = x
        self.y = y
    }
}

public extension ViewBounds {
    
    // MARK: - Public Initializers
    
    ///
    /// Initializes and returns a new `ViewBounds` object with zero `x`, `y`, `width` and `height`.
    ///
    init() {
        
        self.init(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    }
    
    ///
    /// Initializes and returns a new `ViewBounds` object with the specified `height`, and zero `x`,`y` and `width`.
    ///
    /// - Parameters:
    ///     - height: The height of bounds of the view.
    ///
    init(height: CGFloat) {
        
        self.init(x: 0.0, y: 0.0, width: 0.0, height: height)
    }
    
    ///
    /// Initializes and returns a new `ViewBounds` object with the specified `size`, and zero `x` and `y`.
    ///
    /// - Parameters:
    ///     - size: The size of bounds of the view.
    ///
    init(size: CGSize) {
        
        self.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
    }
    
    ///
    /// Initializes and returns a new `ViewBounds` object with the specified `width`, and zero `x`, `y` and `height`.
    ///
    /// - Parameters:
    ///     - width: The width of bounds of the view.
    ///
    init(width: CGFloat) {
        
        self.init(x: 0.0, y: 0.0, width: width, height: 0.0)
    }
    
    ///
    /// Initializes and returns a new `ViewBounds` object with the specified `x`, and zero `y`, `width` and `height`.
    ///
    /// - Parameters:
    ///     - x: The x-coordinate of the origin of bounds of the view.
    ///
    init(x: CGFloat) {
        
        self.init(x: x, y: 0.0, width: 0.0, height: 0.0)
    }
    
    ///
    /// Initializes and returns a new `ViewBounds` object with the specified `y`, and zero `x`, `width` and `height`.
    ///
    /// - Parameters:
    ///     - y: The y-coordinate of the origin of bounds of the view.
    ///
    init(y: CGFloat) {
        
        self.init(x: 0.0, y: y, width: 0.0, height: 0.0)
    }
}
