//
//  MockAssetRepository.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/8/1.
//

import Foundation

public final class MockAssetRepository: AssetRepository {

    public static let shared = MockAssetRepository()

    private var assets: [Asset]

    private lazy var queue = DispatchQueue(label: "serial-queue-\(Self.self)")

    private init() {
        assets = [
            Asset(name: "Snoopy", detail: "The cutest dog in the world"),
            Asset(name: "Laptop", detail: "MacBook Pro 16-inch 2019"),
            Asset(name: "Cat", detail: "I wish I had one")
        ]
    }

    public func fetchAssets(completion: @escaping (Result<[Asset], Error>) -> Void) {
        delayed {
            completion(.success(self.assets))
        }
    }

    public func saveAsset(_ theAsset: Asset, completion: @escaping (Result<String, Error>) -> Void) {
        defer {
            delayed(0.3) {
                completion(.success(theAsset.uuid))
            }
        }

        for (index, asset) in assets.enumerated() where theAsset.uuid == asset.uuid {
            assets[index] = theAsset
            return
        }

        assets.append(theAsset)
    }

    public func deleteAsset(uuid: String, completion: @escaping (Result<String, Error>) -> Void) {
        assets.removeAll(where: { $0.uuid == uuid })

        delayed(0.3) {
            completion(.success(uuid))
        }
    }

    private func delayed(_ duration: TimeInterval = 1.0, execute: @escaping () -> Void) {
        queue.asyncAfter(wallDeadline: .now() + 1.0, execute: execute)
    }
}
