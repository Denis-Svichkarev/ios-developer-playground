//
//  CategoryTableViewCell.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var itemsCountLabel: UILabel!
    
    // MARK: - Properties
    static let reuseIdentifier = "CategoryTableViewCell"
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        categoryImageView.layer.cornerRadius = 8
        categoryImageView.backgroundColor = .systemGray6
        categoryImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Configuration
    func configure(with category: FurnitureCategory, itemsCount: Int = 0) {
        categoryNameLabel.text = category.displayName
        itemsCountLabel.text = "\(itemsCount) items available"
        categoryImageView.image = UIImage(systemName: category.iconName)
        categoryImageView.tintColor = .systemBlue
    }
}
