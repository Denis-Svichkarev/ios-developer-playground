//
//  RegistrationStateViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import UIKit

protocol RegistrationStateViewControllerDelegate: AnyObject {
    func registerButtonPressed(username: String, password: String)
    func errorOccured()
}

class RegistrationStateViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    private let viewModel = RegisterViewModel(localizationService: LocalizableService())
    
    weak var delegate: RegistrationStateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.screenTitle
        
        usernameTextField.placeholder = viewModel.usernamePlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        confirmPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
        
        registerButton.setTitle(viewModel.registerButtonTitle, for: .normal)
        
        viewModel.delegate = self
    }
    
    @IBAction func onRegisterButtonPressed(_ sender: Any) {
        viewModel.username = usernameTextField.text
        viewModel.password = passwordTextField.text
        viewModel.confirmPassword = confirmPasswordTextField.text
        viewModel.register()
    }
}

extension RegistrationStateViewController: RegisterViewModelDelegate {
    func validationSuccess(username: String, password: String) {
        delegate?.registerButtonPressed(username: username, password: password)
    }
    
    func validationFailed() {
        delegate?.errorOccured()
    }
}
