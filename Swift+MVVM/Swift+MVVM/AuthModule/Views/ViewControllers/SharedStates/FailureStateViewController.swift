//
//  FailureStateViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import UIKit

protocol FailureStateViewControllerDelegate: AnyObject {
    func tryAgainButtonPressed()
}

class FailureStateViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    private let viewModel = AuthFailureViewModel(localizationService: LocalizableService())
    
    weak var delegate: FailureStateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.screenTitle
        tryAgainButton.setTitle(viewModel.tryAgainButtonTitle, for: .normal)
    }
    
    @IBAction func onTryAgainButtonPressed(_ sender: Any) {
        delegate?.tryAgainButtonPressed()
    }
}
