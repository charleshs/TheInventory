//
//  AppearanceManager.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

final class AppearanceManager {

    static let shared = AppearanceManager()

    private init() {}

    func applyDefaultAppearance() {
        UITextField.appearance().font = .systemFont(ofSize: 16, weight: .regular)
        UITextView.appearance().font = .systemFont(ofSize: 16, weight: .regular)
    }
}
