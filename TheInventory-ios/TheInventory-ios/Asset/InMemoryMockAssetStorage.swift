//
//  MockAssetStorage.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation
import InventoryEngine

final class InMemoryMockAssetStorage: AssetObjectDataStore {

    typealias Listener = ChangeListener<[AssetObject]>

    static let shared = InMemoryMockAssetStorage()

    var objects: [AssetObject]

    private var assets: [Asset] { didSet {
        objects = assets.map(AssetObject.init)
        notifyListeners()
    }}

    private var subscribers: [UUID: Listener] = [:]

    private init() {
        assets = [
            Asset(name: "Laptop", detail: "MacBook Pro"),
            Asset(name: "Snoopy", detail: "Cute dog"),
            Asset(name: "Hammer", detail: ""),
        ]

        objects = assets.map(AssetObject.init)
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
            handler(objects)
        }
    }
}

extension InMemoryMockAssetStorage: AssetObjectPersistence {

    func saveAsset(_ object: AssetObject, completion: @escaping (Result<String, Error>) -> Void) {
        if object.isNewAsset {
            let newAsset = Asset(name: object.name, detail: object.detail)
            assets.append(newAsset)
            completion(.success(newAsset.uuid))
        } else {
            assets.mutateElement(where: { object.isSameUuid(as: $0) }) { asset in
                asset.name = object.name
                asset.detail = object.detail
                completion(.success(asset.uuid))
            }
        }
    }
}
