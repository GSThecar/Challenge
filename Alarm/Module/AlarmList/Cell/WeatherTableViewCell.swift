//
//  WeatherTableViewCell.swift
//  Alarm
//
//  Created by 이덕화 on 28/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    static let identifier = "WeatherTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
