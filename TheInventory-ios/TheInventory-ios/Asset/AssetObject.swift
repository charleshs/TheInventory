//
//  AssetObject.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit
import InventoryEngine

public final class AssetObject: NSObject {

    var name: String
    var detail: String
    var images: [UIImage]

    private(set) var uuid: String?

    var isNewAsset: Bool { uuid == nil }

    public static func create() -> AssetObject {
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

    func isDuplicate(of asset: Asset) -> Bool {
        return asset.uuid == uuid
            && asset.name == name
            && asset.detail == detail
    }
}
