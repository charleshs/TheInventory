//
//  FloatingButtonShadow.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit

struct FloatingButtonShadow: ShadowConfiguration {
    var opacity: Float = 1
    var radius: CGFloat = 10
    var width: CGFloat = 0
    var height: CGFloat = 4
    var color: UIColor = .black.withAlphaComponent(0.1)
}
