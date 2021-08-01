//
//  LoadingIndicatorView.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit

@dynamicMemberLookup
final class LoadingIndicatorView: UIView {

    private enum Constant {
        static let top: CGFloat = 16
        static let left: CGFloat = 16
        static let bottom: CGFloat = 16
        static let right: CGFloat = 16
        static let margins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    private let activityIndicatorView = UIActivityIndicatorView(style: .large).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .white
        $0.startAnimating()
    }

    subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<UIActivityIndicatorView, T>) -> T {
        get { activityIndicatorView[keyPath: keyPath] }
        set { activityIndicatorView[keyPath: keyPath] = newValue }
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
        addSubview(activityIndicatorView)
        activityIndicatorView.anchor(to: self, insets: Constant.margins)
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.margins.top),
            activityIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.margins.left),
            trailingAnchor.constraint(equalTo: activityIndicatorView.trailingAnchor, constant: Constant.margins.right),
            bottomAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: Constant.margins.bottom),
        ])

        isUserInteractionEnabled = false
        backgroundColor = .black.withAlphaComponent(0.6)
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
