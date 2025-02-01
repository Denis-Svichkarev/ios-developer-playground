//
//  CustomCardView.swift
//  StudySwift
//
//  Created by Denis Svichkarev on 17/12/24.
//

import UIKit

class CustomCardView: CardView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    private func setupFromNib() {
        if let view = Bundle.main.loadNibNamed("CustomCardView", owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.backgroundColor = .white
            contentView.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: contentView.topAnchor),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
    }
}
