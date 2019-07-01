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
	func saveUserToken(token: Bearer) {
		let data = try? PropertyListEncoder().encode(token)
		defaults.set(data, forKey: Keys.userToken)
	}
	
	
	// MARK: - Loading user token function
	func checkForUserToken() -> Bearer? {
		guard let data = defaults.data(forKey: Keys.userToken) else { return nil }
		let token = try? PropertyListDecoder().decode(Bearer.self, from: data)
		return token
	}
	
	func logoutResetToken() {
		defaults.set(nil, forKey: Keys.userToken)
		defaults.synchronize()
	}
}


