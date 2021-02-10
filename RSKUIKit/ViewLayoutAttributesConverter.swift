//
// ViewLayoutAttributesConverter.swift
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
import RSKFoundation
import UIKit.UIInterface

/// The type of object that represents a converter of layout attributes of the view.
public struct ViewLayoutAttributesConverter: ObjectProtocol {
    
    // MARK: - Public Initializers
    
    ///
    /// Initializes and returns a new `ViewLayoutAttributesConverter` object.
    ///
    public init() {}
}

/// The extension containing methods for converting layout attributes of the view from `.leftToRight` user interface layout direction to the specified one.
public extension ViewLayoutAttributesConverter {
    
    // MARK: - Public Functions
    
    ///
    /// Converts a center point of the view from the `.leftToRight` user interface layout direction to the specified one with respect to the size of the superview's bounds.
    ///
    /// - Parameters:
    ///     - viewCenter: The center point of the view for `.leftToRight` user interface layout direction.
    ///     - userInterfaceLayoutDirection: The layout direction of the user interface to which the center point should be converted.
    ///     - superviewBoundsSize: The size of the superview's bounds.
    ///
    /// - Returns: The converted view's center point.
    ///
    func convert(_ viewCenter: CGPoint, to userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection, withRespectToSuperviewBoundsSize superviewBoundsSize: CGSize) -> CGPoint {
        
        switch userInterfaceLayoutDirection {
            
        case .rightToLeft:
            let viewCenter = CGPoint(x: superviewBoundsSize.width - viewCenter.x, y: viewCenter.y)
            return viewCenter
            
        default:
            return viewCenter
        }
    }
    
    ///
    /// Converts a frame of the view from the `.leftToRight` user interface layout direction to the specified one with respect to the size of the superview's bounds.
    ///
    /// - Parameters:
    ///     - viewFrame: The frame of the view for `.leftToRight` user interface layout direction.
    ///     - userInterfaceLayoutDirection: The layout direction of the user interface to which the view's frame should be converted.
    ///     - superviewBoundsSize: The size of the superview's bounds.
    ///
    /// - Returns: The converted view's frame.
    ///
    func convert(_ viewFrame: CGRect, to userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection, withRespectToSuperviewBoundsSize superviewBoundsSize: CGSize) -> CGRect {
        
        switch userInterfaceLayoutDirection {
            
        case .rightToLeft:
            let origin = CGPoint(x: superviewBoundsSize.width - viewFrame.maxX, y: viewFrame.minY)
            let size = viewFrame.size
            
            let viewFrame = CGRect(origin: origin, size: size)
            return viewFrame
            
        default:
            return viewFrame
        }
    }
    
    ///
    /// Converts a transform of the view from the `.leftToRight` user interface layout direction to the specified one.
    ///
    /// - Parameters:
    ///     - viewTransform: The transform of the view for `.leftToRight` user interface layout direction.
    ///     - userInterfaceLayoutDirection: The layout direction of the user interface to which the view's transform should be converted.
    ///
    /// - Returns: The converted view's transform.
    ///
    func convert(_ viewTransform: CGAffineTransform, to userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection) -> CGAffineTransform {
        
        switch userInterfaceLayoutDirection {
            
        case .rightToLeft:
            let rotation = atan2(viewTransform.b, viewTransform.a)
            let viewTransform = viewTransform.rotated(by: -rotation * 2.0)
            return viewTransform
            
        default:
            return viewTransform
        }
    }
}
