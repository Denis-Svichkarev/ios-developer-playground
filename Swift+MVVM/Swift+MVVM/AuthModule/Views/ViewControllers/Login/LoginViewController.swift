//
//  LoginViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

import UIKit
import Combine

protocol LoginViewControllerDelegate: AnyObject {
    func didTapRegisterButton()
}

class LoginViewController: UIViewController {
    var userViewModel: UserViewModel?
    weak var delegate: LoginViewControllerDelegate?
    var cancellables = Set<AnyCancellable>()
    
    var loginStateViewController: LoginStateViewController!
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
        
        loginStateViewController = storyboard.instantiateViewController(withIdentifier: "LoginStateViewController") as? LoginStateViewController
        loadingStateViewController = storyboard.instantiateViewController(withIdentifier: "LoadingStateViewController") as? LoadingStateViewController
        failureStateViewController = storyboard.instantiateViewController(withIdentifier: "FailureStateViewController") as? FailureStateViewController
 
        loginStateViewController.delegate = self
        failureStateViewController.delegate = self
        
        add(childViewController: loginStateViewController)
    }
    
    private func updateViewState() {
        switch currentState {
        case .initial:
            replace(oldChildViewController: failureStateViewController, with: loginStateViewController)
        case .loading:
            replace(oldChildViewController: loginStateViewController, with: loadingStateViewController)
        case .failure:
            replace(oldChildViewController: loadingStateViewController, with: failureStateViewController)
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

extension LoginViewController: LoginStateViewControllerDelegate {
    func loginButtonPressed(username: String, password: String) {
        currentState = .loading
        Task {
            await userViewModel?.saveUser(username: username, password: password)
        }
    }
    
    func registerButtonPressed() {
        delegate?.didTapRegisterButton()
    }
    
    func errorOccured() {
        currentState = .failure
    }
}

extension LoginViewController: FailureStateViewControllerDelegate {
    func tryAgainButtonPressed() {
        currentState = .initial
    }
}
