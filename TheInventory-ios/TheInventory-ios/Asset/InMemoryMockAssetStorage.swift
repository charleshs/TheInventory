//
//  MockAssetStorage.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation
import InventoryEngine

final class InMemoryMockAssetStorage: AssetItemDataStore {

    typealias Listener = ChangeListener<[AssetItem]>

    static let shared = InMemoryMockAssetStorage()

    var assetItems: [AssetItem]

    private var assets: [Asset] { didSet {
        assetItems = assets.map(AssetItem.init)
        notifyListeners()
    }}

    private var subscribers: [UUID: Listener] = [:]

    private init() {
        assets = [
            Asset(name: "Laptop", detail: "MacBook Pro"),
            Asset(name: "Snoopy", detail: "Cute dog"),
            Asset(name: "Hammer", detail: ""),
        ]

        assetItems = assets.map(AssetItem.init)
    }

    func subscribe(_ subscriber: @escaping Listener) -> AnyCancellable {
        let uuid = UUID()
        subscribers[uuid] = subscriber
        return AnyCancellable { [weak self] in
            self?.subscribers.removeValue(forKey: uuid)
        }
    }

    private func notifyListeners() {
        subscribers.forEach { _, handler in
            handler(assetItems)
        }
    }
}

extension InMemoryMockAssetStorage: SaveAssetItemHandler {

    func saveAssetItem(_ item: AssetItem, completion: @escaping (Result<String, Error>) -> Void) {
        if item.isNewAsset {
            let newAsset = Asset(name: item.name, detail: item.detail)
            assets.append(newAsset)
            completion(.success(newAsset.uuid))
        } else {
            assets.mutateElement(where: { item.isSameUuid(as: $0) }) { asset in
                asset.name = item.name
                asset.detail = item.detail
                completion(.success(asset.uuid))
            }
        }
    }
}
