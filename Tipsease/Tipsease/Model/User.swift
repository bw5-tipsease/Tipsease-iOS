//
//  User.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct User: Codable {
	var tips: [Tip?]
	var name: String
}

