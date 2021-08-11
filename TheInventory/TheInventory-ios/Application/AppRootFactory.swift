//
//  AppRootFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit
import Theme

class AppRootFactory {

    class var shared: AppRootFactory { return appInstance }

    private static let appInstance = AppRootFactory()

    private init() {}

    func makeRoot(withTheme theme: Theme = DefaultTheme()) -> UIViewController {
        let rootVC = getAssetSceneFactory(theme: theme).makeAssetListVC()
        let navigation = AppNavigationController(rootViewController: rootVC).decorated(with: theme)
        return navigation
    }

    func getAssetSceneFactory(theme: Theme) -> AssetSceneFactory {
        return AssetSceneFactory(
            theme: theme,
            dataStore: DefaultAssetObjectDataStore.mock,
            persistence: DefaultAssetObjectDataStore.mock
        )
    }
}
