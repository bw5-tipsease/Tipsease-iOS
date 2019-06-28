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
		} else {
			loginType = .login
			loginButton.setTitle("Sign In", for: .normal)
		}
	}
	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		guard let apiController = apiController else { return }
		if let name = nameTextField.text,
			!name.isEmpty,
			let email = emailTextField.text,
			!email.isEmpty, let password = passwordTextField.text,
			!password.isEmpty {
			let user = User(name: name, email: email, password: password)
			if loginType == .register {
				apiController.register(user: user) { (error) in
					if let error = error {
						print("Error occurred during sign up: \(error)")
					} else {
						DispatchQueue.main.async {
							let alertController = UIAlertController(title: "Sign up Successful", message: "Now please log in.", preferredStyle: .alert)
							let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
							alertController.addAction(alertAction)
							self.present(alertController, animated: true, completion:  {
								self.loginType = .login
								self.segControl.selectedSegmentIndex = 1
								self.loginButton.setTitle("Sign In", for: .normal)
							})
						}
						guard let bearer = apiController.bearer else { return }
						print(bearer.token)
					}
				}
			} else if loginType == .login {
				apiController.login(user: user) { (error) in
					if let error = error {
						print("Error occurred during sign in: \(error)")
					} else {
						DispatchQueue.main.async {
							self.dismiss(animated: true, completion: nil)
						}
					}
				}
			} else {
				print("No luck!")
			}
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
