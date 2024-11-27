//
//  FurnitureCollectionViewCell.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import UIKit

final class FurnitureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var furnitureImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Properties
    static let reuseIdentifier = "FurnitureCollectionViewCell"
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        
        furnitureImageView.backgroundColor = .systemGray6
        furnitureImageView.layer.cornerRadius = 8
        furnitureImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Configuration
    func configure(with item: FurnitureItem) {
        nameLabel.text = item.name
        priceLabel.text = "$\(item.price)"
        furnitureImageView.image = UIImage(systemName: "chair.fill")
    }
}
