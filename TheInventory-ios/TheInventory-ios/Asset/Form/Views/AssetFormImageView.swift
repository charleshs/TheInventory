//
//  AssetFormImageView.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit

final class AssetFormImageView: UIControl {

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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: Constant.highlightAnimationDuration) {
            self.imageView.alpha = 0.8
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: Constant.highlightAnimationDuration) {
            self.imageView.alpha = 1
        }
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
