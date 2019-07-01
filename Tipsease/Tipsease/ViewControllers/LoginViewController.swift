//
//  LoginViewController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

enum LoginType {
	case register
	case login
}

class LoginViewController: UIViewController {

	@IBOutlet var segControl: UISegmentedControl!
	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var loginButton: UIButton!
	
	var apiController: APIController?
	var loginType = LoginType.register
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
		
    }
    
	@IBAction func signInTypeChanged(_ sender: UISegmentedControl) {
		if sender.selectedSegmentIndex == 0 {
			loginType = .register
			loginButton.setTitle("Sign Up", for: .normal)
			nameTextField.isHidden = false
		} else {
			loginType = .login
			loginButton.setTitle("Sign In", for: .normal)
			nameTextField.isHidden = true
		}
	}
	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		switch loginType {
		case .register:
			signUpButtonTapped()
		case .login:
			signInButtonTapped()
		}
	}
	
	private func signUpButtonTapped() {
		guard let apiController = apiController else { return }
		guard let name = nameTextField.text, !name.isEmpty else { return }
		guard let email = emailTextField.text, !email.isEmpty else { return }
		guard let password = passwordTextField.text, password.isEmpty else { return }
		let user = User(name: name, email: email, password: password)
		apiController.register(user: user) { (error) in
			if let error = error {
				print("Error occurred during sign up: \(error)")
			} else {
				DispatchQueue.main.async {
					let alertController = UIAlertController(title: "Sign up successful", message: "Now please log in", preferredStyle: .alert)
					let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
					alertController.addAction(alertAction)
					self.present(alertController, animated: true, completion: {
						self.loginType = .login
						self.segControl.selectedSegmentIndex = 1
						self.loginButton.setTitle("Sign In", for: .normal)
					})
				}
			}
		}
	}
	
	private func signInButtonTapped() {
		guard let apiController = apiController else { return }
		guard let email = emailTextField.text, !email.isEmpty else { return }
		guard let password = passwordTextField.text, !password.isEmpty else { return }
		let user = User(name: nil, email: email, password: password)
		apiController.login(user: user) { (error) in
			if let error = error {
				print("Error occurred during signing in: \(error)")
			} else {
				DispatchQueue.main.async {
					guard apiController.bearer != nil else { return }
					apiController.saveBearer()
					self.dismiss(animated: true, completion: nil)
				}
			}
		}
	}
	
}
