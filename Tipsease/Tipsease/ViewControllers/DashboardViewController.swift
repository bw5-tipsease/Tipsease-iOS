//
//  DashboardViewController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
	
	@IBOutlet var workerTableView: WorkerTableView!
	@IBOutlet var viewForWorkerTableView: UIView!
	
	
	let workers = Workers()
	var tipTextField: UITextField?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadViewIfNeeded()
        workerTableView.delegate = self
		workerTableView.dataSource = self
		viewForWorkerTableView.layer.cornerRadius = 12
		viewForWorkerTableView.layer.masksToBounds = true
		
    }
	
	class SpecialAlertController: UIAlertController {
		
	}
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "WorkerDetailSegue" {
			if let workerDetailVC = segue.destination as? WorkerDetailViewController,
				let indexPath = workerTableView.indexPathForSelectedRow {
					workerDetailVC.worker = workers.workersArray[indexPath.row]
			}
		}
    }
}

class SpcialAlertController: UIAlertController {
}

//extension SpecialAlertController: UITextFieldDelegate {
//	
//}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	
	var formattedText: NumberFormatter {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		numberFormatter.usesGroupingSeparator = true
		numberFormatter.locale = Locale.current
		return numberFormatter
	}
	
	
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let tipAction = UIContextualAction(style: .normal, title: "Tip") { (ac: UIContextualAction, UIView, success) in
			let tipAlertController = UIAlertController(title: "How much would you like to tip \(self.workers.workersArray[indexPath.row].name)?", message: nil, preferredStyle: .alert)
			tipAlertController.addTextField(configurationHandler: { (tipTextField) in
				tipTextField.placeholder = "Enter tip amount"
				tipTextField.keyboardType = .numberPad
				tipTextField.clearButtonMode = .whileEditing
				tipTextField.text = self.formattedText.string(for: tipTextField.text)
//				if tipTextField.isEditing {
//					self.formattedText.string(for: tipTextField.text)
//				}
				
				
//				tipTextField.isEditing = NumberFormatter
				let tipCancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
				let tipActionButton = UIAlertAction(title: "Tip", style: .default, handler: { (tipUIAlertAction) in
					//tip function goes here
					
				
//					func tipFieldDidChange(_ sender: UITextField) {
//						guard var userInput = sender.text else { return }
//						sender.text = formattedText(with: userInput)
//					}
					
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
		return workers.workersArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath) as? WorkerTableViewCell else { return UITableViewCell() }
		cell.workerNameLabel.text = workers.workersArray[indexPath.row].name
		cell.ratingLabel.text = workers.workersArray[indexPath.row].rating
		cell.positionLabel.text = workers.workersArray[indexPath.row].position
		cell.imagePlaceholder.image = workers.workersArray[indexPath.row].image
		cell.accessoryType = .disclosureIndicator
		return cell
	}
}
