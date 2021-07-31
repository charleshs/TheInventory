//
//  AppNavigationController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import UIKit

final class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AppNavigationController: Themeable {

    func decorate(with theme: Theme) {
        overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}
