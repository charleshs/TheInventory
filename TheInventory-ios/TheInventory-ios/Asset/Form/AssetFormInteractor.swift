//
//  AssetFormInteractor.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

protocol AssetFormInteractorDelegate: AnyObject {

    func interactor(_ interactor: AssetFormInteractor, didStartSaveOperationOn asset: AssetItem)
    func interactor(_ interactor: AssetFormInteractor, didFinishSaveOperationWith result: Result<String, Error>)
}

final class AssetFormInteractor: Interactor, AssetFormInteractable {

    weak var delegate: AssetFormInteractorDelegate?

    private let saveHandler: SaveAssetItemHandler

    init(saveHandler: SaveAssetItemHandler) {
        self.saveHandler = saveHandler
    }

    func validateName(_ name: String?) -> Result<String, Error> {
        if let name = name, !name.isEmpty {
            return .success(name)
        } else {
            return .failure(AnyLocalizedError(message: "Name should not be empty"))
        }
    }

    func validateDetail(_ detail: String) -> Result<String, Error> {
        return .success(detail)
    }

    func submitAssetItem(_ item: AssetItem) {
        delegate?.interactor(self, didStartSaveOperationOn: item)
        saveHandler.saveAssetItem(item) { [weak self] result in
            self?.delegate?.interactor(self!, didFinishSaveOperationWith: result)
        }
    }
}
