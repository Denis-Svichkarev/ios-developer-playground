//
//  CardView.swift
//  StudySwift
//
//  Created by Denis Svichkarev on 17/12/24.
//

import UIKit

class CardView: UIView {
   let contentView = UIView()
   
   var cornerRadius: CGFloat = 12 {
       didSet { updateAppearance() }
   }
   
   var shadowOpacity: Float = 0.2 {
       didSet { updateAppearance() }
   }
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       setupView()
   }
   
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       setupView()
   }
   
   private func setupView() {
       backgroundColor = .clear
       addSubview(contentView)
       contentView.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           contentView.topAnchor.constraint(equalTo: topAnchor),
           contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
           contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
           contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
       ])
       
       updateAppearance()
   }
   
   private func updateAppearance() {
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 2)
       layer.shadowOpacity = shadowOpacity
       layer.shadowRadius = 4
       layer.masksToBounds = false
       
       contentView.layer.cornerRadius = cornerRadius
       contentView.layer.masksToBounds = true
       contentView.backgroundColor = .white
       
       layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
   }
   
   override func layoutSubviews() {
       super.layoutSubviews()
       layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
   }
}
