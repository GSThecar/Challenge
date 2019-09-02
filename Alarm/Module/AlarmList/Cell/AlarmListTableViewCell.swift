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
    
    @IBOutlet weak var timeStatusBarView: UIView!
    @IBOutlet weak var repeatStatusBarView: UIView!
    
    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        print(self, #function)
        print(timeStatusBarView.frame.size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
