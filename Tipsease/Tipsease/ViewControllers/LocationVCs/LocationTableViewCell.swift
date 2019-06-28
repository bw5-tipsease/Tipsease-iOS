//
//  LocationTableViewCell.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

	@IBOutlet var locationImage: UIImageView!
	@IBOutlet var locationNameLabel: UILabel!
	@IBOutlet var addressLabel: UILabel!
	
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        locationImage.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
