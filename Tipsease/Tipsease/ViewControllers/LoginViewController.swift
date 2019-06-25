//
//  LoginViewController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet var segControl: UISegmentedControl!
	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var loginButton: UIButton!
	
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 20
		
    }
    
	@IBAction func loginButtonTapped(_ sender: UIButton) {
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
