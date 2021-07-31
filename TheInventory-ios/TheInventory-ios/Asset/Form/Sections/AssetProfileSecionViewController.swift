//
//  AssetProfileSecionViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

final class AssetProfileSecionViewController: UIViewController, AssetObjectUpdatable {

    var assetName: String? { assetNameTextField.text }

    var assetDetail: String { assetDetailTextView.text }

    private lazy var assetNameTextField = AssetFormTextField().then {
        $0.placeholder = "Asset Name"
    }

    private lazy var assetDetailTextView = AssetFormTextView().then {
        $0.isScrollEnabled = false
        $0.textColor = .secondaryLabel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        editorColumnStack.addArrangedSubview(assetNameTextField)
        editorColumnStack.addArrangedSubview(assetDetailTextView)

        editorColumnStack.pasteOn(view)
    }

    func update(by asset: AssetObject) {
        assetNameTextField.text = asset.name
        assetDetailTextView.text = asset.detail
    }

    private lazy var editorColumnStack = UIStackView(axis: .vertical, spacing: 0, distribution: .fill, alignment: .fill)

    private lazy var imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imagesFlowLayout)

    private lazy var imagesFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
}
