//
//  ListScrollView.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit
import DevKit

open class ListScrollView: UIView {

    public enum Size {
        case fill
        case natural(Alignment)
    }

    public enum Alignment {
        case leading
        case center
        case trailing
    }

    public final var size: Size = .fill { didSet {
        remakeConstraintsForStackView()
    }}

    public final var contentInsets: UIEdgeInsets = .zero { didSet {
        remakeConstraintsForStackView()
    }}

    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView(axis: .vertical, spacing: 8, distribution: .fill, alignment: .fill)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private var constraintsForStackView: [NSLayoutConstraint] = []

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
}

extension ListScrollView {

    open func append(_ newView: UIView, spacingPrev: CGFloat? = nil, spacingNext: CGFloat? = nil) {
        stackView.addArrangedSubview(newView, spacingPrev: spacingPrev, spacingNext: spacingNext)
    }

    open func insert(_ newView: UIView, at index: Int, spacingPrev: CGFloat? = nil, spacingNext: CGFloat? = nil) {
        stackView.insertArrangedSubview(newView, at: index, spacingPrev: spacingPrev, spacingNext: spacingNext)
    }

    open func insert(_ newView: UIView, after existingView: UIView, spacingPrev: CGFloat? = nil, spacingNext: CGFloat? = nil) {
        stackView.insertArrangedSubview(newView, after: existingView, spacingPrev: spacingPrev, spacingNext: spacingNext)
    }

    open func insert(_ newView: UIView, before existingView: UIView, spacingPrev: CGFloat? = nil, spacingNext: CGFloat? = nil) {
        stackView.insertArrangedSubview(newView, before: existingView, spacingPrev: spacingPrev, spacingNext: spacingNext)
    }

    open func replace(_ oldView: UIView, with newView: UIView) {
        stackView.replaceArrangedSubview(oldView, with: newView)
    }

    open func remove(_ subview: UIView) {
        stackView.removeArrangedSubview(subview)
    }

    open func removeAll() {
        stackView.clearArrangedSubviews()
    }
}

extension ListScrollView {

    @IBInspectable
    public final var spacing: CGFloat {
        get {
            return stackView.spacing
        }
        set(spacing) {
            stackView.spacing = spacing
        }
    }

    @IBInspectable
    public final var distribution: UIStackView.Distribution {
        get {
            return stackView.distribution
        }
        set(distribution) {
            stackView.distribution = distribution
        }
    }

    @IBInspectable
    public final var alignment: UIStackView.Alignment {
        get {
            return stackView.alignment
        }
        set(alignment) {
            stackView.alignment = alignment
        }
    }
}

extension ListScrollView {

    private func initSetup() {
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        applyInitialConstraints()
    }

    private func applyInitialConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ]

        constraintsForStackView = produceConstraintsForStackView()
        NSLayoutConstraint.activate([scrollViewConstraints, constraintsForStackView].flatMap { $0 })
    }

    private func remakeConstraintsForStackView() {
        NSLayoutConstraint.deactivate(constraintsForStackView)
        constraintsForStackView = produceConstraintsForStackView()
        NSLayoutConstraint.activate(constraintsForStackView)
    }

    private func produceConstraintsForStackView() -> [NSLayoutConstraint] {
        typealias Reference<Anchor> = (anchor: Anchor, constant: CGFloat)

        let leading: Reference<NSLayoutXAxisAnchor> = (scrollView.frameLayoutGuide.leadingAnchor, contentInsets.left)
        let trailing: Reference<NSLayoutXAxisAnchor> = (scrollView.frameLayoutGuide.trailingAnchor, contentInsets.right)
        let top: Reference<NSLayoutYAxisAnchor> = (scrollView.contentLayoutGuide.topAnchor, contentInsets.top)
        let bottom: Reference<NSLayoutYAxisAnchor> = (scrollView.contentLayoutGuide.bottomAnchor, contentInsets.bottom)
        let centerX: Reference<NSLayoutXAxisAnchor> = (scrollView.frameLayoutGuide.centerXAnchor, .zero)

        let verticalConstraints = [
            stackView.topAnchor.constraint(equalTo: top.anchor, constant: top.constant),
            bottom.anchor.constraint(equalTo: stackView.bottomAnchor, constant: bottom.constant),
        ]

        let horizontalConstraints: [NSLayoutConstraint]
        switch size {
        case .fill:
            horizontalConstraints = [
                stackView.leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant),
                trailing.anchor.constraint(equalTo: stackView.trailingAnchor, constant: trailing.constant),
            ]
        case .natural(let alignment):
            switch alignment {
            case .leading:
                horizontalConstraints = [
                    stackView.leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant),
                    trailing.anchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: trailing.constant),
                ]
            case .center:
                horizontalConstraints = [
                    stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leading.anchor, constant: leading.constant),
                    stackView.centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant),
                    trailing.anchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: trailing.constant),
                ]
            case .trailing:
                horizontalConstraints = [
                    stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leading.anchor, constant: leading.constant),
                    trailing.anchor.constraint(equalTo: stackView.trailingAnchor, constant: trailing.constant),
                ]
            }
        }
        return [verticalConstraints, horizontalConstraints].flatMap { $0 }
    }
}
