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
	
	
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let tipAction = UITableViewRowAction(style: .normal, title: "Tip") { (action, indexPath) in
			let tipAlertController = UIAlertController(title: "How much would you like to tip \(self.workers.workersArray[indexPath.row].name)?", message: nil, preferredStyle: .alert)
			tipAlertController.addTextField(configurationHandler: { (tipTextField) in
				tipTextField.placeholder = "Enter tip amount"
				let tipActionButton = UIAlertAction(title: "Tip", style: .default, handler: { (tipUIAlertAction) in
					//tip function goes here!
				})
				let tipCancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
				tipAlertController.addAction(tipActionButton)
				tipAlertController.addAction(tipCancelButton)
			})
			self.present(tipAlertController, animated: true, completion: nil)
			
			print("Handle tip action here.")
		}
		tipAction.backgroundColor = Colors.primaryGreen
		return [tipAction]
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		<#code#>
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workers.workersArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath) as? WorkerTableViewCell else { return UITableViewCell() }
		cell.workerNameLabel.text = workers.workersArray[indexPath.row].name
		cell.ratingLabel.text = workers.workersArray[indexPath.row].rating
		cell.positionLabel.text = workers.workersArray[indexPath.row].position
		cell.accessoryType = .disclosureIndicator
		return cell
	}
}

