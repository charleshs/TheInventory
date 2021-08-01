//
//  AssetFormViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/28.
//

import UIKit

public protocol AssetFormInteractable {

    func validateName(_ name: String?) -> Result<String, Error>
    func validateDetail(_ detail: String) -> Result<String, Error>
    func submitAsset(_ asset: AssetObject)
}

public final class AssetFormViewController: ViewController, LoadingStatusIndicatable {

    var interactor: AssetFormInteractable?

    private let presenter: AssetFormPresentable

    private let asset: AssetObject

    private lazy var profileSectionVC = AssetProfileSecionViewController()

    private struct Constant {
        static let contentInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    }

    private lazy var listScrollView: ListScrollView = {
        let listScrollView = ListScrollView()
        listScrollView.translatesAutoresizingMaskIntoConstraints = false
        listScrollView.size = .fill
        listScrollView.contentInsets = Constant.contentInsets
        return listScrollView
    }()

    init(presenter: AssetFormPresentable) {
        self.presenter = presenter
        self.asset = presenter.assetObject
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }

    private func initSetup() {
        addChild(profileSectionVC)
        listScrollView.append(profileSectionVC.view)
        profileSectionVC.didMove(toParent: self)
        profileSectionVC.update(by: asset)

        layoutListScrollView()

        navigationItem.rightBarButtonItems = [saveBarButton]
    }

    private func layoutListScrollView() {
        view.addSubview(listScrollView)
        listScrollView.anchor(to: view.safeAreaLayoutGuide, insets: .zero)
    }

    private lazy var saveBarButton =
        UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveBarButtonTapped))

    @objc private func saveBarButtonTapped() {
        guard let interactor = interactor else {
            return print("Interactor is missing in \(Self.self)")
        }
        do {
            asset.name = try interactor.validateName(profileSectionVC.assetName).get()
            asset.detail = try interactor.validateDetail(profileSectionVC.assetDetail).get()
            interactor.submitAsset(asset)
            view.endEditing(false)
        } catch {
            print(error)
        }
    }
}

extension AssetFormViewController: Themeable {

    public func decorate(with theme: Theme) {
        overrideUserInterfaceStyle = theme.userInterfaceStyle
        view.backgroundColor = theme.mainBackground
    }
}

extension AssetFormViewController: AssetFormPresentableDelegate {

    func loadingStatusChanged(_ presenter: AssetFormPresentable, isLoading: Bool) {
        isLoading ? startLoading() : stopLoading()
    }

    func assetObjectSaved(_ presenter: AssetFormPresentable) {
        navigationController?.popViewController(animated: true)
    }
}
