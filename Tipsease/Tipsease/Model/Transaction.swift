//
//  Transaction.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct Transaction:Codable {
    var id: Int
    var tipperId: Int
	var serverId: Int
    var tipPaid: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case tipperId = "tipper_id"
        case serverId = "server_id"
        case tipPaid = "tip_paid"
    }
}
