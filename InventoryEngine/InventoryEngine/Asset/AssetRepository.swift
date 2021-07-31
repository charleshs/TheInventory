//
//  AssetRepository.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/8/1.
//

import Foundation

public protocol AssetRepository {

    func fetchAssets(completion: @escaping (Result<[Asset], Error>) -> Void)

    func saveAsset(_: Asset, completion: @escaping (Result<String, Error>) -> Void)

    func deleteAsset(uuid: String, completion: @escaping (Result<String, Error>) -> Void)
}
