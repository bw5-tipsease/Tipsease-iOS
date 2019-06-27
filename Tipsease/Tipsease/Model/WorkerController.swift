//
//  WorkerController.swift
//  Tipsease
//
//  Created by Alex Shillingford on 6/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import UIKit

class WorkerController {
    init() {
        self.workers = [
        let alexAdams = Worker(name: "Alex Adams", locations: [chilis], rating: "0.5/5", tips: nil, tagline: "Donuts make me go nuts!", image: UIImage(named: "Alex Adams"))
        let catherineMyers = Worker(name: "Catherine Myers", locations: [takashi], rating: "4.9/5", tips: nil, tagline: "World class service with a smile!", image: UIImage(named: "Catherine Myers"))
        let marcusJames = Worker(name: "Marcus James", locations: [texasRoadhouse], rating: "4.1/5", tips: nil, tagline: "Country road, take me home.", image: UIImage(named: "Marcus James"))
        let jessicaFitzgerald = Worker(name: "Jessica Fitzgerald", locations: [chilis], rating: "2.6/5", tips: nil, tagline: "I want my baby back baby back baby back.", image: UIImage(named: "Jessica Fitzgerald"))
        let philOReily = Worker(name: "Phil O-Reily", locations: [chrisSteakhouse], rating: "4.75/5", tips: nil, tagline: "Family friendly steak house", image: UIImage(named: "Phil O-Reily"))
        let paulineAnderson = Worker(name: "Pauline Anderson", locations: [redIguana], rating: "3.6/5", tips: nil, tagline: "Every day is a fiesta!", image: UIImage(named: "Pauline Anderson"))
        let louisColdiron = Worker(name: "Louis Coldiron", locations: [redIguana], rating: "5/5", tips: nil, tagline: "Most problems can be solved with our world-famous empanadas!", image: UIImage(named: "Louis Coldiron"))
        let kennethMitchell = Worker(name: "Kenneth Mitchell", locations: [texasRoadhouse], rating: "4.25/5", tips: nil, tagline: "Live like you were dying", image: UIImage(named: "Kenneth Mitchell"))
        let sonyaNichols = Worker(name: "Sonya Nichols", locations: [chrisSteakhouse], rating: "4.9/5", tips: nil, tagline: "Donuts make me go nuts!", image: UIImage(named: "Sonya Nichols"))
        let salFiefia = Worker(name: "Sal Fiefia", locations: [chilis], rating: "3.5/5", tips: nil, tagline: "Order the grilled chicken breast with honey mustard!", image: UIImage(named: "Sal Fiefia"))
        ]
    }
    
    var workers: [Worker] = []
    let chilis = Location(name: "Chili's", address: "123 Avocado Ave, Fresno, CA, 93650", image: UIImage(named: "Chili's")!, duration: nil)
    let texasRoadhouse = Location(name: "Texas Roadhouse", address: "555 Barbeque Blvd, Austin, TX", image: UIImage(named: "Texas Roadhouse")!, duration: nil)
    let chrisSteakhouse = Location(name: "Christopher's Steak House", address: "10 W 100 S, Salt Lake City, Utah, 84101", image: UIImage(named: "Christopher's Steak House")!, duration: nil)
    let takashi = Location(name: "Takashi Sushi Restaurant", address: "456 Sashimi Street, Utica, NY, 12121", image: UIImage(named: "Takashi")!, duration: nil)
    let redIguana = Location(name: "Red Iguana", address: "200 S North Temple, Salt Lake City, Utah, 84101", image: UIImage(named: "Red Iguana"), duration: nil)
    
}
