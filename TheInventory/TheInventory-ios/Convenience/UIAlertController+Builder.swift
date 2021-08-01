//
//  UIAlertController+Builder.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit

extension UIAlertController {

    public func withAction(
        title: String?,
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
        return self
    }

    public func withPreferredAction(
        title: String?,
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
        preferredAction = action
        return self
    }
}
