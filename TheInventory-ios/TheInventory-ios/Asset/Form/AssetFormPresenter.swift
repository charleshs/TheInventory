//
//  AssetFormPresenter.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import UIKit

protocol AssetFormPresentableDelegate: AnyObject {

    func loadingStatusChanged(_ presenter: AssetFormPresentable, isLoading: Bool)

    func assetItemSaved(_ presenter: AssetFormPresentable)
}

protocol AssetFormPresentable {

    var delegate: AssetFormPresentableDelegate? { get set }

    var assetItem: AssetItem { get }
}

final class AssetFormPresenter: Presenter, AssetFormPresentable {

    weak var delegate: AssetFormPresentableDelegate?

    let assetItem: AssetItem

    init(assetItem: AssetItem) {
        self.assetItem = assetItem
    }
}

extension AssetFormPresenter: AssetFormInteractorDelegate {

    func interactor(_ interactor: AssetFormInteractor, didStartSaveOperationOn asset: AssetItem) {
        delegate?.loadingStatusChanged(self, isLoading: true)
    }

    func interactor(_ interactor: AssetFormInteractor, didFinishSaveOperationWith result: Result<String, Error>) {
        delegate?.loadingStatusChanged(self, isLoading: false)

        switch result {
        case .failure(_):
            // Todo: handle error
            break
        case .success(_):
            delegate?.assetItemSaved(self)
        }
    }
}
