//
//  ViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit
import Theme

open class ViewController: UIViewController {

    deinit {
        print("\(self) deinit")
    }
}

open class ThemeViewController: ViewController, Themeable {

    open func decorate(with theme: Theme) {
        overrideUserInterfaceStyle = theme.userInterfaceStyle
        view.backgroundColor = theme.mainBackground
    }
}
