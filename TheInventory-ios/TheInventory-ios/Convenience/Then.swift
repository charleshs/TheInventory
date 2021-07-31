//
//  Then.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import Foundation

#if !os(Linux)
import CoreGraphics
#endif

#if canImport(UIKit)
import UIKit.UIGeometry
#endif

public protocol Then {}

extension Then where Self: Any {

    public func `do`(_ expression: (Self) throws -> Void) rethrows {
        try expression(self)
    }

    public func with(_ configuration: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try configuration(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {

    public func then(_ configuration: (Self) throws -> Void) rethrows -> Self {
        try configuration(self)
        return self
    }
}

extension NSObject: Then {}
extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}

#if !os(Linux)
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}
#endif

#if canImport(UIKit)
extension UIEdgeInsets: Then {}
extension UIOffset: Then {}
extension UIRectEdge: Then {}
#endif
