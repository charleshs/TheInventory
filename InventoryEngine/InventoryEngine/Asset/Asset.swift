//
//  Asset.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/7/27.
//

import Foundation

public typealias AssetIdentifier = String

public struct Asset: Hashable {

    public let uuid: AssetIdentifier

    public var name: String

    public var detail: String

    public let dateCreated: Date

    public internal(set) var dateUpdated: Date

    public init(name: String, detail: String, dateCreated: Date = Date()) {
        self.uuid = UUID().uuidString
        self.dateCreated = dateCreated
        self.dateUpdated = dateCreated
        self.name = name
        self.detail = detail
    }
}
