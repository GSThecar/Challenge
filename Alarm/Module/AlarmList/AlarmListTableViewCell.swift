//
//  AlarmListTableViewCell.swift
//  Alarm
//
//  Created by 이덕화 on 23/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmListTableViewCell"

    
    
    @IBOutlet weak var testlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
