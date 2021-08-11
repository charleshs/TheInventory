//
//  Themeable.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import Foundation

public protocol Themeable {

    func decorate(with theme: Theme)
}

extension Themeable {

    public func decorated(with theme: Theme) -> Self {
        self.decorate(with: theme)
        return self
    }
}
