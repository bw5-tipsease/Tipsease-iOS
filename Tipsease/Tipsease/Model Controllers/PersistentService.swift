//
//  PersistentService.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation



class PersistentService {
	
	struct Keys {
		static let userToken = "userToken"
	}
	
	let defaults = UserDefaults.standard
	
	// MARK: - Saving user token function
	func saveUserToken(token: String) {
		defaults.set(token, forKey: Keys.userToken)
		print(token)
	}
	
	
	// MARK: - Loading user token function
	func checkForUserToken(bearerToken: String) {
		let userToken = defaults.value(forKey: Keys.userToken) as? String ?? nil
		guard let existingUserToken = userToken else { return }
		bearerToken.token = existingUserToken
	}
}


