//
//  AssetLocation.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/7/27.
//

import Foundation

public struct AssetLocation: Hashable {

    let uuid: String

    var name: String

    public init(name: String) {
        self.uuid = UUID().uuidString
        self.name = name
    }
}
