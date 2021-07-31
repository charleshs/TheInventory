//
//  ComingSoonViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

open class ComingSoonViewController: UIViewController {

    open var featureName: String { didSet {
        updateComingSoonLabel(text: featureName)
    }}

    private lazy var comingSoonLabel: UILabel = .comingSoon()

    public init(featureName: String = String(describing: self)) {
        self.featureName = featureName
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        self.featureName = String(describing: Self.self)
        super.init(coder: coder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
        updateComingSoonLabel(text: featureName)
    }

    private func initSetup() {
        comingSoonLabel.frame = view.bounds
        comingSoonLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(comingSoonLabel)
    }

    private func updateComingSoonLabel(text: String) {
        comingSoonLabel.text = "Coming Soon - \(text)"
    }
}

private extension UILabel {

    static func comingSoon() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.backgroundColor = .systemBackground
        return label
    }
}
