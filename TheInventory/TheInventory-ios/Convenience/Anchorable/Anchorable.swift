//
//  Anchorable.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit

public protocol Anchorable {

    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension Anchorable {

    public func anchor(to layoutGuide: Anchorable, insets: UIEdgeInsets) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom),
        ])
    }
}
