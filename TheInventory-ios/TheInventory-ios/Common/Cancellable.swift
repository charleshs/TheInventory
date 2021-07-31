//
//  Cancellable.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

public protocol Cancellable {

    func cancel()
}

public final class AnyCancellable: Cancellable {

    private let cancellation: (() -> Void)?

    public init(_ onCancel: @escaping () -> Void) {
        cancellation = onCancel
    }

    deinit {
        cancel()
    }

    public func cancel() {
        cancellation?()
    }
}
