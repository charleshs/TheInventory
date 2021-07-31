//
//  AssetItemDataStore.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

public protocol AssetItemDataStore: AnyObject {

    var assetItems: [AssetItem] { get }

    func subscribe(_ handler: @escaping ChangeListener<[AssetItem]>) -> AnyCancellable
}

public protocol SaveAssetItemHandler {

    /// Save an asset item and provide the asset id in a completion callback.
    func saveAssetItem(_ item: AssetItem, completion: @escaping (Result<String, Error>) -> Void)
}
