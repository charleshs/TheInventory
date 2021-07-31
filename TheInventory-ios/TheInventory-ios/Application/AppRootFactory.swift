//
//  AppRootFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

class AppRootFactory {

    class var shared: AppRootFactory { return appInstance }

    private static let appInstance = AppRootFactory()

    private init() {}

    func makeRoot(withTheme theme: Theme = DefaultTheme()) -> UIViewController {
        let rootVC = getAssetSceneFactory().makeAssetList()
        let navigation = AppNavigationController(rootViewController: rootVC)
        navigation.decorate(with: theme)
        return navigation
    }

    func getAssetSceneFactory() -> AssetSceneFactory {
        return AssetSceneFactory()
    }
}
