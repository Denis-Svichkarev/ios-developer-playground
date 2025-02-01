//
//  UIComponentsController.swift
//  StudySwift
//
//  Created by Denis Svichkarev on 17/12/24.
//

import UIKit

class UIComponentsController: UIViewController {
    @IBOutlet weak var animatedButton: AnimatedButton!
    @IBOutlet weak var cardView: CustomCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animatedButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        measureTime ({
            let button = AnimatedButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
            button.setTitle("Tap Me", for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            view.addSubview(button)
        }, name: "Animated Button")
        
        measureTime({
            let cardView = CardView(frame: CGRect(x: 20, y: 160, width: 100, height: 100))
            cardView.cornerRadius = 16
            cardView.shadowOpacity = 0.3

            let label = UILabel()
            label.text = "Card Content"
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            
            cardView.contentView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: cardView.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: cardView.contentView.centerYAnchor)
            ])
                    
            view.addSubview(cardView)
        }, name: "Card View")
    }
    
    @objc func buttonTapped() {
        print("animated button tapped")
    }
    
    func measureTime(_ block: () -> Void, name: String) {
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Time passed \(name): \(diff) seconds")
    }
}
