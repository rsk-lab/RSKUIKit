//
// ViewFrame.swift
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

/// The type of object that represents a frame of the view.
public struct ViewFrame: RectProtocol {
    
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
