//
//  ShadowConfiguration.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import UIKit

public protocol ShadowConfiguration {

    var opacity: Float { get }
    var radius: CGFloat { get }
    var width: CGFloat { get }
    var height: CGFloat { get }
    var color: UIColor { get }
    var path: CGPath? { get }
}

public extension ShadowConfiguration {
    
    var path: CGPath? { nil }
}
