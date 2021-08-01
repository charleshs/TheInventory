//
//  UIView+Layout.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

extension UIView {
    
    public func pasteOn(_ parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor),
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
        ])
    }
}
