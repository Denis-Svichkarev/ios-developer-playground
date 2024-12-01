//
//  CatalogViewController.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import UIKit

final class CatalogViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let viewModel: CatalogViewModel
    
    // MARK: - Initialization
    init(viewModel: CatalogViewModel = CatalogViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "CatalogViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "CategoryTableViewCell", bundle: nil),
            forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = 80
    }
    
    private func setupNavigationBar() {
        title = "AR Furniture"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FurnitureCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        let category = FurnitureCategory.allCases[indexPath.row]
        cell.configure(with: category)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = FurnitureCategory.allCases[indexPath.row]
        coordinator?.showCategoryDetail(category: category)
    }
}
