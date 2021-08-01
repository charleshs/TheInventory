//
//  AssetListUIComponents.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit

struct AssetListUIComponents {
    
    static func floatingAddButton() -> Button {
        let button = RoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.uiButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.uiButton.setImage(UIImage(systemName: "plus")?.resizableImage(withCapInsets: .zero), for: .normal)
        button.uiButton.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.dropShadow(with: FloatingButtonShadow())
        return button
    }
}
