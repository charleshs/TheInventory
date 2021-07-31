//
//  AssetListViewController.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import UIKit

final class AssetListViewController: UIViewController {

    private let dataStore: AssetObjectDataStore

    init(dataStore: AssetObjectDataStore) {
        self.dataStore = dataStore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) lazy var listTableView = UITableView(frame: .zero, style: .plain).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
    }

    private lazy var floatingAddButton: Button = RoundedButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.uiButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.uiButton.setImage(UIImage(systemName: "plus")?.resizableImage(withCapInsets: .zero), for: .normal)
        $0.uiButton.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        $0.dropShadow(with: FloatingButtonShadow())
        $0.addTarget(self, action: #selector(tapFloatingAddButton), for: .touchUpInside)
    }

    @objc private func tapFloatingAddButton() {
        let assetFormVC = AssetSceneFactory().makeAssetForm(AssetObject.create())
        navigationController?.pushViewController(assetFormVC, animated: true)
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
            DispatchQueue.main.async {
                self?.listTableView.reloadData()
            }
        }
    }

    private func layoutListTableView() {
        view.addSubview(listTableView)
        listTableView.anchor(to: view.safeAreaLayoutGuide, insets: .zero)
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
        let assetFormVC = AssetSceneFactory().makeAssetForm(asset)
        navigationController?.pushViewController(assetFormVC, animated: true)
    }
}

private struct FloatingButtonShadow: ShadowConfiguration {
    var opacity: Float = 1
    var radius: CGFloat = 8
    var width: CGFloat = 0
    var height: CGFloat = 4
    var color: UIColor = .black.withAlphaComponent(0.2)
}
