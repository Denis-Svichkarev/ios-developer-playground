//
//  LoginStateViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import UIKit

protocol LoginStateViewControllerDelegate: AnyObject {
    func loginButtonPressed(username: String, password: String)
    func registerButtonPressed()
    func errorOccured()
}

class LoginStateViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private let viewModel = LoginViewModel(localizationService: LocalizableService())
    
    weak var delegate: LoginStateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.screenTitle
        
        usernameTextField.placeholder = viewModel.usernamePlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        
        loginButton.setTitle(viewModel.loginButtonTitle, for: .normal)
        registerButton.setTitle(viewModel.registerButtonTitle, for: .normal)
        
        viewModel.delegate = self
    }

    @IBAction func onLoginButtonPressed(_ sender: Any) {
        viewModel.username = usernameTextField.text
        viewModel.password = passwordTextField.text
        viewModel.login()
    }
      
    @IBAction func onRegisterButtonPressed(_ sender: Any) {
        delegate?.registerButtonPressed()
    }
}

extension LoginStateViewController: LoginViewModelDelegate {
    func validationSuccess(username: String, password: String) {
        delegate?.loginButtonPressed(username: username, password: password)
    }
    
    func validationFailed() {
        delegate?.errorOccured()
    }
}
