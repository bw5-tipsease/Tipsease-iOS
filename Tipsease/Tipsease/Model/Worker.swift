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
	var name: String
	var rating: String
	var location: String
	var tips: [Transaction]
}

struct Location: Codable {
	let name: String
	let address: String
}


//class Workers {
//    var workersArray: [Worker] = [
//        Worker(name: "Brett Baker", rating: "3 out of 5", location: "Westchester"),
//        Worker(name: "Benedict Cumberbatch", rating: "4.5 out of 6", location: "San Francisco"),
//        Worker(name: "Rick Sanchez", rating: "0.5 out of 5", location: "Shitsville"),
//        Worker(name: "Peter Pencils", rating: "4.1 out of 5", location: "El Dorado Hills"),
//        Worker(name: "Sarah Conklin", rating: "3.6 out of 5", location: "Beverly Nils")
//    ]
//
//    init() {
//    }
//}
