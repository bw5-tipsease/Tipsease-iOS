//
//  Worker.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import UIKit

struct Worker {
	var name: String
	var rating: String
	var position: String
	var location: String
	var image: UIImage
}

struct Location {
	let name: String
	let address: String
}

// TODO: -- Fix Array

class Workers {
	var workersArray: [Worker] = [
		Worker(name: "Brett Baker", rating: "3 out of 5", position: "Bartender", location: "Westchester", image:#imageLiteral(resourceName: "user-placeholder.png") ),
		Worker(name: "Benedict Cumberbatch", rating: "4.5 out of 6", position: "Bell Hop", location: "San Francisco", image: #imageLiteral(resourceName: "user-placeholder.png")),
		Worker(name: "Rick Sanchez", rating: "0.5 out of 5", position: "Server", location: "Shitsville", image: #imageLiteral(resourceName: "user-placeholder.png")),
		Worker(name: "Peter Pencils", rating: "4.1 out of 5", position: "Valet", location: "El Dorado Hills", image: #imageLiteral(resourceName: "user-placeholder.png")),
		Worker(name: "Sarah Conklin", rating: "3.6 out of 5", position: "Bartender", location: "Beverly Nils", image: #imageLiteral(resourceName: "user-placeholder.png"))
	]
	
	init() {
	}
}
