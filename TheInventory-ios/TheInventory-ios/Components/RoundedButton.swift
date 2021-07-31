//
//  RoundedButton.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import UIKit

class RoundedButton: Button {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = bounds.height / 2
    }
}
