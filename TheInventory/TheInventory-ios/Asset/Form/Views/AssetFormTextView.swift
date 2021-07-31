//
//  AssetFormTextView.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit

final class AssetFormTextView: TextView, EdgeLineConfigurable {

    private struct Constant {

        static let textContainerInsets = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        static let bottomLineInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    override func initSetup() {
        textContainerInset = Constant.textContainerInsets
        textContainer.lineFragmentPadding = .zero
        setupBottomLine()
    }

    private func setupBottomLine() {
        if let textContainerView = findSubviews(withClassName: "_UITextContainerView").first {
            addBottomLine(on: textContainerView, withColor: .lightGray, insets: Constant.bottomLineInsets)
        }
    }
}
