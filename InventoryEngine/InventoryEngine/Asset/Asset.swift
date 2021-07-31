//
//  Asset.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/7/27.
//

import Foundation

public struct Asset: Hashable {

    let uuid: String

    var name: String

    let dateCreated: Date

    var dateUpdated: Date

    public init(name: String, dateCreated: Date = Date()) {
        self.uuid = UUID().uuidString
        self.dateCreated = dateCreated
        self.dateUpdated = dateCreated
        self.name = name
    }
}
