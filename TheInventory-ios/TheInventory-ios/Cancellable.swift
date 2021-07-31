//
//  Observer.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

public final class Cancellable {

    private let cancellation: (() -> Void)?

    init(_ onCancel: @escaping () -> Void) {
        cancellation = onCancel
    }

    deinit {
        cancel()
    }

    func cancel() {
        cancellation?()
    }
}
