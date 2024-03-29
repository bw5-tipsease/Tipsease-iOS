//
//  WorkerDetailViewController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class WorkerDetailViewController: UIViewController, UITextFieldDelegate {

//	var workerController: WorkerController?
	var apiController: APIController?
	var workerImage: UIImage?
	var server: Worker? {
		didSet {
			loadViewIfNeeded()
			updateViews()
		}
	}
	var amountTypedString2 = ""
	
	
	
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
	
	let layerGradient = CAGradientLayer()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		tipAmountOneLabel.textColor = Colors.primaryGreen
		tipAmountTwoLabel.textColor = Colors.primaryGreen
		tipAmountThreeLabel.textColor = Colors.primaryGreen
		
		
//		locationAndDurationLabel.text = "\(locationStr.joined(separator: ", "))"
//		if let workerObject = worker {
//			taglineTextView.text = "\"\(workerObject.tagline)\""
//			for location in workerObject.locations {
//				locationStr.append(location.name)
//			}
//		}
		
		//TODO: - Gradient Button
		layerGradient.colors = [Colors.secondaryBlue.cgColor, Colors.deeperBlue.cgColor]
		layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
		layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
		layerGradient.frame = CGRect(x: 0, y: 0, width: leaveTipButton.bounds.width, height: leaveTipButton.bounds.height)
		leaveTipButton.layer.addSublayer(layerGradient)
		leaveTipButton.layer.cornerRadius = 20
    }
	
	func updateViews() {
		guard let server = server else { return }
		guard isViewLoaded else { return }
		self.title = server.name
		taglineTextView.text = server.tagline
		locationAndDurationLabel.text = String(server.location)
		
	}
    
	@IBAction func leaveTipButtonTapped(_ sender: UIButton) {
		triggerAlert()
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	func triggerAlert() {
		self.amountTypedString2 = ""
		guard let workerObject = server else { return }
		let tipAlertController = UIAlertController(title: "How much would you like to tip \(workerObject.name)?", message: nil, preferredStyle: .alert)
		tipAlertController.addTextField(configurationHandler: { (tipTextField) in
			tipTextField.delegate = self
			tipTextField.placeholder = "Enter tip amount"
			tipTextField.keyboardType = .numberPad
			let tipCancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			let tipActionButton = UIAlertAction(title: "Tip", style: .default, handler: { (tipUIAlertAction) in
				guard let tipFromTextField = tipTextField.text else { return }
				let secondAlert = UIAlertController(title: "Are you sure \(String(describing: tipFromTextField)) is the correct amount that you want to tip?", message: "", preferredStyle: .alert)
				let secondAlertNoAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
				let secondAlertYesAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
				secondAlert.addAction(secondAlertYesAction)
				secondAlert.addAction(secondAlertNoAction)
				self.present(secondAlert, animated: true, completion: nil)
				
			})
			tipAlertController.addAction(tipCancelButton)
			tipAlertController.addAction(tipActionButton)
			self.present(tipAlertController, animated: true, completion: nil)
		})
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let formatter = NumberFormatter()
		formatter.locale = Locale.current
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		
		if string.count > 0 {
			amountTypedString2 += string
			let decNumber = NSDecimalNumber(string: amountTypedString2).multiplying(by: 0.01)
			let newString = "$" + formatter.string(from: decNumber)!
			textField.text = newString
		} else {
			amountTypedString2 = String(amountTypedString2.dropLast())
			if amountTypedString2.count > 0 {
				let decNumber = NSDecimalNumber(string: amountTypedString2).multiplying(by: 0.01)
				let newString = "$" +  formatter.string(from: decNumber)!
				textField.text = newString
			} else {
				textField.text = "$0.00"
			}
		}
		return false
	}
	

}

