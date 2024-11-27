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
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            let width = (view.frame.width - 30) / 2
            layout.itemSize = CGSize(width: width, height: width * 1.3)
        }
    }
    
    // MARK: - Private Methods
    private func loadData() {
        Task {
            do {
                try await viewModel.loadFurniture()
                collectionView.reloadData()
            } catch {
                print("Error loading furniture: \(error)")
            }
        }
    }
}


// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FurnitureCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? FurnitureCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = viewModel.items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
