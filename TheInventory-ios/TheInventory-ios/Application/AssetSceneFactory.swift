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

    func makeAssetList() -> UIViewController {
        let dataStore = InMemoryMockAssetStorage.shared
        return decorated { AssetListViewController(dataStore: dataStore) }
    }

    func makeAssetForm(_ assetItem: AssetItem) -> UIViewController {
        let saveHandler = InMemoryMockAssetStorage.shared
        let interactor = AssetFormInteractor(saveHandler: saveHandler)
        let presenter = AssetFormPresenter(assetItem: assetItem)
        let viewController = AssetFormViewController(presenter: presenter)

        viewController.interactor = interactor
        interactor.delegate = presenter
        presenter.delegate = viewController

        return decorated { viewController }
    }
}
