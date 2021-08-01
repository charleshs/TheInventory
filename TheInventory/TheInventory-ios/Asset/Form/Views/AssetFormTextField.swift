//
//  AssetFormTextField.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit

final class AssetFormTextField: TextField, EdgeLineConfigurable {

    private struct Constant {

        static let contentInsets = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        static let bottomLineInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }

    private func initSetup() {
        contentInsets = Constant.contentInsets
        borderStyle = .none
        addBottomLine(onTo: self, withColor: .lightGray, insets: Constant.bottomLineInsets)
    }
}

extension CGFloat {
    static var pixel: CGFloat {
        return 1 / UIScreen.main.scale
    }
}
