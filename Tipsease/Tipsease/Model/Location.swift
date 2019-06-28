//
//  Location.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import UIKit


struct Location: Codable {
	var name: String
	var location: String
	var imageUrl: String
	var id: Int
	var description: String
	
	enum CodingKeys: String, CodingKey {
		case name
		case location
		case imageUrl = "image_url"
		case id
		case description
	}
}
