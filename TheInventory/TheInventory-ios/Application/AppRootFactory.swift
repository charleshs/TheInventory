//
//  AppRootFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit
import Theme

class AppRootFactory: ThemeableFactory {

    class var shared: AppRootFactory { return appInstance }

    var theme: Theme = DefaultTheme()

    private static let appInstance = AppRootFactory()

    private init() {}

    func makeRoot(withTheme theme: Theme = DefaultTheme()) -> UIViewController {
        self.theme = theme

        let rootVC = getAssetSceneFactory().makeAssetListVC()
        let navigation = decorated {
            AppNavigationController(rootViewController: rootVC)
        }
        return navigation
    }

    func getAssetSceneFactory() -> AssetSceneFactory {
        return AssetSceneFactory(
            theme: theme,
            dataStore: DefaultAssetObjectDataStore.mock,
            persistence: DefaultAssetObjectDataStore.mock
        )
    }
}
