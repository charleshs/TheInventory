//
//  Button.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import UIKit

open class Button: UIControl, ViewShadowable {

    public var cornerRadius: CGFloat {
        get { uiButton.layer.cornerRadius }
        set {
            uiButton.layer.cornerRadius = newValue
            shadowView.layer.cornerRadius = newValue
        }
    }

    public var uiButton: UIButton { _wrappingButton }

    private let _wrappingButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }

    private lazy var shadowView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = false
        $0.layer.shouldRasterize = true
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }

    private func initSetup() {
        addSubview(uiButton)
        uiButton.pasteOn(self)
        uiButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }

    public func enableShadow() {
        guard subviews.contains(shadowView) else {
            insertSubview(shadowView, belowSubview: uiButton)
            shadowView.anchor(to: safeAreaLayoutGuide, insets: .zero)
            return enableShadow()
        }

        shadowView.backgroundColor = .white
        shadowView.dropShadow(opacity: 1, radius: 8, offset: CGSize(width: 0, height: 4), color: .black.withAlphaComponent(0.2))
    }

    @objc private func tapButton() {
        sendActions(for: .touchUpInside)
    }
}

public protocol ViewShadowable {

    func enableShadow()
}
