//
//  LoadingStatusIndicatable.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/8/1.
//

import UIKit

public protocol LoadingStatusIndicatable {

    func startLoading()
    func stopLoading()
}

public extension LoadingStatusIndicatable where Self: ViewController {

    private var key: String { "\(ObjectIdentifier(self))" }

    private var loadingView: UIView {
        if let exist = viewPool[key] {
            return exist
        }
        // Create new one
        return LoadingIndicatorView().then {
            viewPool[key] = $0
            view.addSubview($0)
            makeCenteredInRootView(subview: $0)
            $0.alpha = State.hidden.alpha
        }
    }

    func startLoading() {
        guard loadingView.alpha == State.hidden.alpha else { return }

        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = State.displayed.alpha
            self.loadingView.isHidden = State.displayed.isHidden
        }
    }

    func stopLoading() {
        guard loadingView.alpha == State.displayed.alpha else { return }

        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = State.hidden.alpha
        } completion: { [weak self] _ in
            self?.loadingView.isHidden = State.hidden.isHidden
        }
    }

    private func makeCenteredInRootView(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

private enum State: CGFloat {
    case displayed = 1
    case hidden = 0

    var alpha: CGFloat { rawValue }
    var isHidden: Bool { self == .hidden }
}

private var viewPool: [String: UIView] = [:]
