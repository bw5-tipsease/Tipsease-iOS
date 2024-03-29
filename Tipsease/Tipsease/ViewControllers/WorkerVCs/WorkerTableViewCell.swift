//
//  WorkerTableViewCell.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class WorkerTableViewCell: UITableViewCell {

	@IBOutlet var workerNameLabel: UILabel!
	@IBOutlet var positionLabel: UILabel!
	@IBOutlet var ratingLabel: UILabel!
	@IBOutlet var imagePlaceholder: UIImageView!
	
	
	
	var worker: Worker? {
		didSet {
//			updateViews()
		}
	}
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
		imagePlaceholder.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	

}
