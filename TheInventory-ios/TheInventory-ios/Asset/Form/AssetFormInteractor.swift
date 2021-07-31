//
//  AssetFormInteractor.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/31.
//

import Foundation

protocol AssetFormInteractorDelegate: AnyObject {

    func interactor(_ interactor: AssetFormInteractor, didStartSaveOperationOn asset: AssetObject)
    func interactor(_ interactor: AssetFormInteractor, didFinishSaveOperationWith result: Result<String, Error>)
}

final class AssetFormInteractor: Interactor, AssetFormInteractable {

    weak var delegate: AssetFormInteractorDelegate?

    private let saveHandler: AssetObjectPersistence

    init(saveHandler: AssetObjectPersistence) {
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

    func submitAsset(_ asset: AssetObject) {
        delegate?.interactor(self, didStartSaveOperationOn: asset)
        saveHandler.saveAsset(asset) { [weak self] result in
            self?.delegate?.interactor(self!, didFinishSaveOperationWith: result)
        }
    }
}
