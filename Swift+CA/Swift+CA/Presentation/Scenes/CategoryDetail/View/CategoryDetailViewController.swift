//
//  CategoryDetailViewController.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import UIKit

final class CategoryDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - UI Components
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    // MARK: - Properties
    private let viewModel: CategoryDetailViewModel
    weak var coordinator: AppCoordinator?
    
    // MARK: - Initialization
    init(viewModel: CategoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CategoryDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupActivityIndicator()
        setupBindings()
        loadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = viewModel.category.displayName
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "FurnitureCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: FurnitureCollectionViewCell.reuseIdentifier
        )
        collectionView.refreshControl = refreshControl
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            let width = (view.frame.width - 30) / 2
            layout.itemSize = CGSize(width: width, height: width * 1.3)
        }
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupBindings() {
        Task { [weak self] in
            guard let self = self else { return }
            for await state in self.viewModel.$state.values {
                await MainActor.run {
                    self.updateUI(for: state)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func loadData() {
        Task {
            await viewModel.loadFurniture()
        }
    }
    
    @objc private func pullToRefresh() {
        loadData()
    }
    
    @MainActor
    private func updateUI(for state: CategoryDetailViewModel.State) {
        switch state {
        case .idle:
            collectionView.isHidden = true
            errorLabel.isHidden = true
            activityIndicator.stopAnimating()
            
        case .loading:
            collectionView.isHidden = true
            errorLabel.isHidden = true
            activityIndicator.startAnimating()
            
        case .loaded(let items):
            collectionView.isHidden = false
            errorLabel.isHidden = true
            activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
            collectionView.reloadData()
            
        case .error(let message):
            collectionView.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = message
            activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if case let .loaded(items) = viewModel.state {
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FurnitureCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? FurnitureCollectionViewCell,
        case let .loaded(items) = viewModel.state else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .loaded(items) = viewModel.state else { return }
        let item = items[indexPath.row]
        coordinator?.showAR(for: item)
    }
}
