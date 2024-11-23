//
//  LoadingStateViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import UIKit

class LoadingStateViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    private let viewModel = AuthLoadingViewModel(localizationService: LocalizableService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.screenTitle
    }
}
