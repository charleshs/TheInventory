//
//  AssetFormViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

public final class AssetFormViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }

    private func initSetup() {}
}

extension AssetFormViewController: Themeable {

    public func decorate(with theme: Theme) {
        view.backgroundColor = theme.mainBackground
    }
}
