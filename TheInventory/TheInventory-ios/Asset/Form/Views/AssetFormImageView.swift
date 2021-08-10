//
//  AssetFormImageView.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit

final class AssetFormImageView: UIControl {

    override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            renderForHighlightState()
        }
    }

    private struct Constant {
        static let imageViewCornerRadius: CGFloat = 8
        static let highlightAnimationDuration: TimeInterval = 0.2
    }

    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            addImageViewToHierarchyIfNeeded()
        }
    }

    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.imageViewCornerRadius
        return imageView
    }()

    private func renderForHighlightState() {
        UIView.animate(withDuration: Constant.highlightAnimationDuration,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveLinear],
                       animations: {
                        self.imageView.alpha = self.isHighlighted ? 0.8 : 1
                       })
    }

    private func addImageViewToHierarchyIfNeeded() {
        if imageView.superview == nil {
            addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        }
    }
}
