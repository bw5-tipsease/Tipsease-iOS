//
//  WorkerDetailViewController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class WorkerDetailViewController: UIViewController {

	var worker: Worker?
	
	@IBOutlet var workerProfileImage: UIImageView!
	@IBOutlet var leaveTipButton: UIButton!
	@IBOutlet var locationAndDurationLabel: UILabel!
	@IBOutlet var dateOneLabel: UILabel!
	@IBOutlet var dateTwoLabel: UILabel!
	@IBOutlet var dateThreeLabel: UILabel!
	@IBOutlet var locationOneLabel: UILabel!
	@IBOutlet var locationTwoLabel: UILabel!
	@IBOutlet var locationThreeLabel: UILabel!
	@IBOutlet var tipAmountOneLabel: UILabel!
	@IBOutlet var tipAmountTwoLabel: UILabel!
	@IBOutlet var tipAmountThreeLabel: UILabel!
	@IBOutlet var taglineTextView: UITextView!
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		leaveTipButton.layer.cornerRadius = 20
		tipAmountOneLabel.textColor = Colors.primaryGreen
		tipAmountTwoLabel.textColor = Colors.primaryGreen
		tipAmountThreeLabel.textColor = Colors.primaryGreen
		self.title = worker?.name
		locationAndDurationLabel.text = "\(worker!.location) - 4 months"
    }
    
	@IBAction func leaveTipButtonTapped(_ sender: UIButton) {
		
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
