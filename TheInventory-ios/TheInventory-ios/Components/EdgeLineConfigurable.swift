//
//  EdgeLineConfigurable.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

public protocol EdgeLineConfigurable {

    func addTopLine(on targetView: UIView, withColor color: UIColor, insets: UIEdgeInsets)
    func addBottomLine(on targetView: UIView, withColor color: UIColor, insets: UIEdgeInsets)
}

extension EdgeLineConfigurable {

    public func addTopLine(on targetView: UIView, withColor color: UIColor, insets: UIEdgeInsets = .zero) {
        let line = UIView()
        line.backgroundColor = color
        line.translatesAutoresizingMaskIntoConstraints = false
        targetView.addSubview(line)
        let lineHeight = 1 / UIScreen.main.scale
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: lineHeight),
            line.topAnchor.constraint(equalTo: targetView.topAnchor, constant: insets.top).with(priority: .defaultHigh),
            line.leftAnchor.constraint(equalTo: targetView.leftAnchor, constant: insets.left).with(priority: .defaultHigh),
            line.rightAnchor.constraint(equalTo: targetView.rightAnchor, constant: -insets.right).with(priority: .defaultHigh),
        ])
    }

    public func addBottomLine(on targetView: UIView, withColor color: UIColor, insets: UIEdgeInsets = .zero) {
        let line = UIView()
        line.backgroundColor = color
        line.translatesAutoresizingMaskIntoConstraints = false
        targetView.addSubview(line)
        let lineHeight = 1 / UIScreen.main.scale
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: lineHeight),
            line.leftAnchor.constraint(equalTo: targetView.leftAnchor, constant: insets.left).with(priority: .defaultHigh),
            line.rightAnchor.constraint(equalTo: targetView.rightAnchor, constant: -insets.right).with(priority: .defaultHigh),
            line.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -insets.bottom).with(priority: .defaultHigh),
        ])
    }
}

private extension NSLayoutConstraint {
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
