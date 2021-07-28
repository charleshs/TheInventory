//
//  AssetImage.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/7/27.
//

import Foundation

public struct AssetImage {

    let asset: Asset

    let description: String

    let imageUri: String

    let dateCreated: Date

    var dateUpdated: Date

    public init(asset: Asset, description: String, imageUri: String, dateCreated: Date = Date()) {
        self.asset = asset
        self.description = description
        self.imageUri = imageUri
        self.dateCreated = dateCreated
        self.dateUpdated = dateCreated
    }
}
