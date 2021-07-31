//
//  AssetItem.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit
import InventoryEngine

public final class AssetItem: NSObject {

    var isNewAsset: Bool { uuid == nil }

    var name: String
    var detail: String
    var images: [UIImage]

    private var uuid: String?

    public static func create() -> AssetItem {
        return .init(name: "", detail: "")
    }

    public init(name: String, detail: String, images: [UIImage] = []) {
        self.name = name
        self.detail = detail
        self.images = images
    }

    public init(asset: Asset) {
        uuid = asset.uuid
        name = asset.name
        detail = asset.detail
        images = []
    }

    public func isSameUuid(as asset: Asset) -> Bool {
        return uuid == asset.uuid
    }
}
