//
//  AlarmListTableViewCell.swift
//  MyAlarm
//
//  Created by 이덕화 on 14/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "AlarmListTableViewCell"

    @IBOutlet weak var alarmImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var repeatStatusStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(alarm: Alarm) {
        update(name: alarm.name)
        update(date: alarm.date)
    }
    
    private func update(name: String?) {
        if name == "Quick" {
            alarmImageView.image = UIImage(named: "IconQuickAlarm_Normal")
        } else {
            alarmImageView.image = UIImage(named: "filled_icon-navi-01-dis.1_Normal")
        }
    }
    
    private func update(date: Date?) {
        timeLabel.text = date?.toString(format: "yyyy-MM-dd HH:mm:ss") ?? "-"
    }
    
}

class TopRoundContentView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

class BottomRoundContentView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
