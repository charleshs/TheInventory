//
//  ThemeableFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

protocol ThemeableFactory {

    var theme: Theme { get }
}

extension ThemeableFactory {
    
    func decorated<T: UIViewController>(viewController creator: () -> T) -> T {
        let controller = creator()
        if let themeable = controller as? Themeable {
            themeable.decorate(with: theme)
        }
        return controller
    }
}
