//
//  AssetLocationImage.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/7/27.
//

import Foundation

public struct AssetLocationImage{

    let assetLocation: AssetLocation

    var description: String

    let imageUri: String

    let dateCreated: Date

    public init(assetLocation: AssetLocation, description: String, imageUri: String, dateCreated: Date = Date()) {
        self.assetLocation = assetLocation
        self.description = description
        self.imageUri = imageUri
        self.dateCreated = dateCreated
    }
}
