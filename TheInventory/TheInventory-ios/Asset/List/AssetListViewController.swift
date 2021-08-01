//
//  AssetListViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

final class AssetListViewController: UIViewController {

    private let sceneFactory: AssetSceneFactory
    private let dataStore: AssetObjectDataStore

    init(sceneFactory: AssetSceneFactory, dataStore: AssetObjectDataStore) {
        self.sceneFactory = sceneFactory
        self.dataStore = dataStore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataStore()
        layoutListTableView()
        layoutFloatingAddButton()
    }

    private var dataStoreListener: Cancellable?
    private func setupDataStore() {
        dataStoreListener = dataStore.subscribe { [weak self] _ in
            print("Data store updated")
            self?.listTableView.reloadData()
        }
    }

    // MARK: - List table view
    private(set) lazy var listTableView = UITableView(frame: .zero, style: .plain).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
    }

    private func layoutListTableView() {
        view.addSubview(listTableView)
        listTableView.anchor(to: view.safeAreaLayoutGuide, insets: .zero)
    }

    // MARK: - Floating "Add" button
    private lazy var floatingAddButton: Button = AssetListUIComponents.floatingAddButton().then {
        $0.addTarget(self, action: #selector(floatingAddButtonTapped), for: .touchUpInside)
    }

    @objc private func floatingAddButtonTapped() {
        let assetFormVC = sceneFactory.makeAssetFormVC(AssetObject.create())
        navigationController?.pushViewController(assetFormVC, animated: true)
    }

    private func layoutFloatingAddButton() {
        view.addSubview(floatingAddButton)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            floatingAddButton.widthAnchor.constraint(equalTo: floatingAddButton.heightAnchor),
            floatingAddButton.heightAnchor.constraint(equalToConstant: 48),
            floatingAddButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            floatingAddButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -24),
        ])
    }
}

extension AssetListViewController: Themeable {

    func decorate(with theme: Theme) {
        overrideUserInterfaceStyle = theme.userInterfaceStyle
        view.backgroundColor = theme.mainBackground
    }
}

extension AssetListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let asset = dataStore.objects[indexPath.row]

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = asset.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let asset = dataStore.objects[indexPath.row]
        let assetFormVC = sceneFactory.makeAssetFormVC(asset)
        navigationController?.pushViewController(assetFormVC, animated: true)
    }
}
