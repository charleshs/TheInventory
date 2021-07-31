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

public final class AssetFormViewController: UIViewController {

    var interactor: AssetFormInteractable?

    private let presenter: AssetFormPresentable

    private let asset: AssetObject

    private lazy var profileSectionVC = AssetProfileSecionViewController()

    private struct Constant {
        static let contentInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    }

    private(set) lazy var assetImageView: AssetFormImageView = {
        let imageView = AssetFormImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        return imageView
    }()

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

    deinit {
        print("deinit - \(self)")
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

//        let assetImageViewStack = UIStackView(axis: .vertical, spacing: 0, distribution: .fill, alignment: .leading)
//        assetImageViewStack.addArrangedSubview(assetImageView)
//        listScrollView.append(assetImageViewStack, spacingPrev: 16)

//        assetImageView.image = UIColor.lightGray.toImage()
//        assetImageView.addTarget(self, action: #selector(presentImagePickerController), for: .touchUpInside)

        layoutListScrollView()

        navigationItem.rightBarButtonItems = [
            makeSaveBarButton()
        ]
    }

    private func layoutListScrollView() {
        view.addSubview(listScrollView)
        listScrollView.anchor(to: view.safeAreaLayoutGuide, insets: .zero)
    }

//    @objc private func presentImagePickerController() {
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        present(vc, animated: true, completion: nil)
//    }

    private func makeSaveBarButton() -> UIBarButtonItem {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(tapSaveBarButton))
        return saveButton
    }

    @objc private func tapSaveBarButton() {
        guard let interactor = interactor else {
            return print("Interactor is missing in \(Self.self)")
        }
        do {
            asset.name = try interactor.validateName(profileSectionVC.assetName).get()
            asset.detail = try interactor.validateDetail(profileSectionVC.assetDetail).get()
            interactor.submitAsset(asset)
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

    }

    func assetObjectSaved(_ presenter: AssetFormPresentable) {
        navigationController?.popViewController(animated: true)
    }
}

//extension AssetFormViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            let targetSize = CGSize(width: 300, height: 300)
//            let resizedImage = UIGraphicsImageRenderer(size: targetSize).image { rendererContext in
//                image.draw(in: CGRect(origin: .zero, size: targetSize))
//            }
//            assetImageView.image = resizedImage
//            picker.presentingViewController?.dismiss(animated: true, completion: nil)
//        }
//    }
//}
