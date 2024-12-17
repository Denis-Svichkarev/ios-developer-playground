//
//  AnimatedButton.swift
//  StudySwift
//
//  Created by Denis Svichkarev on 17/12/24.
//

import UIKit

@IBDesignable
class AnimatedButton: UIButton {
    @IBInspectable var originalScale: CGFloat = 1.0 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    @IBInspectable var pressedScale: CGFloat = 0.95 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    @IBInspectable var buttonCornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = buttonCornerRadius
        }
    }
    
    @IBInspectable var customBackgroundColor: UIColor = .systemBlue {
        didSet {
            backgroundColor = customBackgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .systemBlue
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func touchDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: self.pressedScale, y: self.pressedScale)
        }
    }
    
    @objc private func touchUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: self.originalScale, y: self.originalScale)
        }
    }
}
