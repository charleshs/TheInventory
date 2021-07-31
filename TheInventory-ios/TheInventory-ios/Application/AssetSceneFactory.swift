//
//  AssetSceneFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

struct AssetSceneFactory: ThemeableFactory {

    let theme: Theme

    init(theme: Theme = DefaultTheme()) {
        self.theme = theme
    }

    func makeAssetForm() -> UIViewController {
        return decorated { AssetFormViewController() }
    }
}
