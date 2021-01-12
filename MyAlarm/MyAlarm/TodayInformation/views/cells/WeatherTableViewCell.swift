//
//  WeatherTableViewCell.swift
//  MyAlarm
//
//  Created by 이덕화 on 28/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "WeatherTableViewCell"
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var localAndStatusLabel: UILabel!
    
    @IBOutlet weak var compareLabel: UILabel!
    
    @IBOutlet weak var maxMinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
