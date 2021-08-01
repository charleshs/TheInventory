//
//  AssetObjectDataStore.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

public protocol AssetObjectDataStore: AnyObject {

    var objects: [AssetObject] { get }

    func subscribe(_ handler: @escaping ChangeListener<[AssetObject]>) -> Cancellable
}

public protocol AssetObjectPersistence {

    /// Save an asset object and provide the asset id in a completion callback.
    func saveAsset(_ object: AssetObject, completion: @escaping (Result<String, Error>) -> Void)
}
