//
//  AnyLocalizedError.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

public struct AnyLocalizedError: LocalizedError {

    public var message: String

    public var errorDescription: String? {
        return message
    }
}
