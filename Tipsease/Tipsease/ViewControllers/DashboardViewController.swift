//
//  DashboardViewController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
	
	// MARK: - Properties and Outlets
	
	@IBOutlet var workerTableView: WorkerTableView!
	@IBOutlet var viewForWorkerTableView: UIView!
	
	let workerController = WorkerController()
	var amountTypedString = ""
	
	
	//MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadViewIfNeeded()
        workerTableView.delegate = self
		workerTableView.dataSource = self
		viewForWorkerTableView.layer.cornerRadius = 12
		viewForWorkerTableView.layer.masksToBounds = true
    }

	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "WorkerDetailSegue" {
			if let workerDetailVC = segue.destination as? WorkerDetailViewController,
				let indexPath = workerTableView.indexPathForSelectedRow {
					workerDetailVC.workerController = workerController
					workerDetailVC.worker = workerController.workers[indexPath.row]
			}
		}
    }
}

// MARK: - Extensions

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let tipAction = UIContextualAction(style: .normal, title: "Tip") { (ac: UIContextualAction, UIView, success) in
			self.amountTypedString = ""
			let tipAlertController = UIAlertController(title: "How much would you like to tip \(self.workerController.workers[indexPath.row].name)?", message: nil, preferredStyle: .alert)
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
			success(true)
		}
		tipAction.image = UIImage(named: "money96")
		tipAction.backgroundColor = Colors.primaryGreen
		return UISwipeActionsConfiguration(actions: [tipAction])
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workerController.workers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath) as? WorkerTableViewCell else { return UITableViewCell() }
		cell.workerNameLabel.text = workerController.workers[indexPath.row].name
		cell.ratingLabel.text = workerController.workers[indexPath.row].rating
		cell.accessoryType = .disclosureIndicator
		return cell
	}
}


extension DashboardViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let formatter = NumberFormatter()
		formatter.locale = Locale.current
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		
		if string.count > 0 {
			amountTypedString += string
			let decNumber = NSDecimalNumber(string: amountTypedString).multiplying(by: 0.01)
			let newString = "$" + formatter.string(from: decNumber)!
			textField.text = newString
		} else {
			amountTypedString = String(amountTypedString.dropLast())
			if amountTypedString.count > 0 {
				let decNumber = NSDecimalNumber(string: amountTypedString).multiplying(by: 0.01)
				let newString = "$" +  formatter.string(from: decNumber)!
				textField.text = newString
			} else {
				textField.text = "$0.00"
			}
		}
		return false
	}
}