//
//  LoadingViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 30/06/24.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var loadingLabel: UILabel!
    
    private let viewModel = LoadingViewModel(localizationService: LocalizableService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingLabel.text = viewModel.loadingTitle
        
        view.backgroundColor = .white
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
}
