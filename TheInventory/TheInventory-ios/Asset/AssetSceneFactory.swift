//
//  AssetSceneFactory.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

public struct AssetSceneFactory: ThemeableFactory {

    public let theme: Theme
    public let dataStore: AssetObjectDataStore
    public let persistence: AssetObjectPersistence

    public init(theme: Theme, dataStore: AssetObjectDataStore, persistence: AssetObjectPersistence) {
        self.theme = theme
        self.dataStore = dataStore
        self.persistence = persistence
    }

    public func makeAssetListVC() -> UIViewController {
        return decorated { AssetListViewController(sceneFactory: self, dataStore: dataStore) }
    }

    public func makeAssetFormVC(_ asset: AssetObject) -> UIViewController {
        let interactor = AssetFormInteractor(persistence: persistence)
        let presenter = AssetFormPresenter(assetObject: asset)
        let viewController = AssetFormViewController(presenter: presenter)

        viewController.interactor = interactor
        interactor.delegate = presenter
        presenter.delegate = viewController

        return decorated { viewController }
    }
}
