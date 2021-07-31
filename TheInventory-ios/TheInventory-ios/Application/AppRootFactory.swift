//
//  AppRootFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

final class AppRootFactory {

    func makeRoot() -> UIViewController {
        getAssetSceneFactory().makeAssetForm()
    }

    func getAssetSceneFactory() -> AssetSceneFactory {
        return AssetSceneFactory()
    }
}
