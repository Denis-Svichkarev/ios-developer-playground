//
//  RegistrationViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    var userViewModel: UserViewModel?
    var cancellables = Set<AnyCancellable>()
    
    var registrationStateViewController: RegistrationStateViewController!
    var loadingStateViewController: LoadingStateViewController!
    var failureStateViewController: FailureStateViewController!
   
    var currentState: LoginState = .initial {
        didSet {
            updateViewState()
        }
    }
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        
        registrationStateViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationStateViewController") as? RegistrationStateViewController
        loadingStateViewController = storyboard.instantiateViewController(withIdentifier: "LoadingStateViewController") as? LoadingStateViewController
        failureStateViewController = storyboard.instantiateViewController(withIdentifier: "FailureStateViewController") as? FailureStateViewController
 
        registrationStateViewController.delegate = self
        failureStateViewController.delegate = self
        
        add(childViewController: registrationStateViewController)
    }
    
    private func updateViewState() {
        switch currentState {
        case .initial:
            replace(oldChildViewController: failureStateViewController, with: registrationStateViewController)
        case .loading:
            replace(oldChildViewController: registrationStateViewController, with: loadingStateViewController)
        case .failure:
            replace(oldChildViewController: loadingStateViewController, with: failureStateViewController)
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

extension RegistrationViewController: RegistrationStateViewControllerDelegate {
    func registerButtonPressed(username: String, password: String) {
        currentState = .loading
        Task {
            await userViewModel?.saveUser(username: username, password: password)
        }
    }
    
    func errorOccured() {
        currentState = .failure
    }
}

extension RegistrationViewController: FailureStateViewControllerDelegate {
    func tryAgainButtonPressed() {
        currentState = .initial
    }
}

