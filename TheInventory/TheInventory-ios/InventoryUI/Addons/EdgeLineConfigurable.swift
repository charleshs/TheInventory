//
//  EdgeLineConfigurable.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

public protocol EdgeLineConfigurable {

    var displayScale: CGFloat { get }

    func addTopLine(onTo view: UIView, withColor color: UIColor, insets: UIEdgeInsets, height: CGFloat)
    func addBottomLine(onTo view: UIView, withColor color: UIColor, insets: UIEdgeInsets, height: CGFloat)
}

extension EdgeLineConfigurable {

    public var displayScale: CGFloat {
        return UIScreen.main.scale
    }

    public func addTopLine(
        onTo view: UIView,
        withColor color: UIColor,
        insets: UIEdgeInsets = .zero,
        height: CGFloat = 1
    ) {
        let line = prepareHorizontalLine(onTo: view, lineColor: color, lineHeight: height / displayScale)
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).setDefaultHigh(),
            line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).setDefaultHigh(),
            line.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).setDefaultHigh(),
        ])
    }

    public func addBottomLine(
        onTo view: UIView,
        withColor color: UIColor,
        insets: UIEdgeInsets = .zero,
        height: CGFloat = 1
    ) {
        let line = prepareHorizontalLine(onTo: view, lineColor: color, lineHeight: height / displayScale)
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).setDefaultHigh(),
            line.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).setDefaultHigh(),
            line.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).setDefaultHigh(),
        ])
    }

    private func prepareHorizontalLine(onTo view: UIView, lineColor: UIColor, lineHeight: CGFloat) -> UIView {
        let line = prepareLine(onTo: view, lineColor: lineColor)
        line.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
        return line
    }

    private func prepareLine(onTo view: UIView, lineColor: UIColor) -> UIView {
        let line = UIView()
        line.backgroundColor = lineColor
        line.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(line)
        return line
    }
}

private extension NSLayoutConstraint {
    func setDefaultHigh() -> Self {
        self.priority = .defaultHigh
        return self
    }
}
