//
//  MockAssetStorage.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation
import InventoryEngine

final class DefaultAssetObjectDataStore: AssetObjectDataStore {

    static let mock = DefaultAssetObjectDataStore(repository: MockAssetRepository.shared)

    typealias Listener = ChangeListener<[AssetObject]>

    var objects: [AssetObject] = [] { didSet {
        guard objects != oldValue else { return }
        notifyListenersForObjectChanges()
    }}

    private var assets: [Asset] = [] { didSet {
        objects = assets.map(AssetObject.init)
    }}

    private let repository: AssetRepository

    private var subscribers: [UUID: Listener] = [:]

    init(repository: AssetRepository) {
        self.repository = repository
        loadData()
    }

    func refreshData(completion: @escaping (Error?) -> Void) {
        loadData { error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }

    func subscribe(_ subscriber: @escaping Listener) -> Cancellable {
        let uuid = UUID()
        subscribers[uuid] = subscriber
        return AnyCancellable { [weak self] in
            self?.subscribers.removeValue(forKey: uuid)
        }
    }

    private func loadData(completion: ((Error?) -> Void)? = nil) {
        repository.fetchAssets { [weak self] result in
            switch result {
            case .failure(let error):
                completion?(error)
            case .success(let assets):
                completion?(nil)
                self?.assets = assets
            }
        }
    }

    private func notifyListenersForObjectChanges() {
        subscribers.forEach { _, handler in
            DispatchQueue.main.async {
                handler(self.objects)
            }
        }
    }
}

extension DefaultAssetObjectDataStore: AssetObjectPersistence {

    func saveAsset(_ object: AssetObject, completion: @escaping (Result<AssetIdentifier, Error>) -> Void) {
        // Construct "Asset" from "AssetObject"
        if object.isNewAsset {
            let newAsset = Asset(name: object.name, detail: object.detail)
            saveAssetWithRepository(newAsset, completion: completion)
        }
        else if var asset = assets.first(where: { object.uuid == $0.uuid }) {
            // Early completion when nothing has changed
            if object.isDuplicate(of: asset) {
                return completion(.success(asset.uuid))
            }
            asset.name = object.name
            asset.detail = object.detail
            saveAssetWithRepository(asset, completion: completion)
        }
        else {
            // Todo: return a `CriticalError` that's supposed to cause a crash.
            let errMsg = "Critical fault: the object (UUID: \(object.uuid!)) doesn't match any asset in `assets`."
            completion(.failure(AnyLocalizedError(message: errMsg)))
        }
    }

    private func saveAssetWithRepository(_ asset: Asset, completion: @escaping (Result<AssetIdentifier, Error>) -> Void) {
        repository.saveAsset(asset) { [weak self] result in
            DispatchQueue.main.async {
                if case .success = result {
                    self?.loadData()
                }
                completion(result)
            }
        }
    }
}
