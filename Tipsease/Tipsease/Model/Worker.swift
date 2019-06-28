//
//  Worker.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import UIKit


struct Worker: Codable {
    var id: Int
	var name: String
	var location: Int
	var rating: Int
	var transactions: [Transaction]
	var tagline: String
	var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case imageUrl = "thumbnail_url"
        case location = "restaurant_id"
        case transactions
        case tagline
    }
}


