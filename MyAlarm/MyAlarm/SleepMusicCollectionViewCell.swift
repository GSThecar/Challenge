//
//  SleepMusicCollectionViewCell.swift
//  MyAlarm
//
//  Created by 이덕화 on 23/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class SleepMusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "SleepMusicCollectionViewCell"
    
    @IBOutlet weak var musicImageView: UIImageView!
    
    @IBOutlet weak var musicNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        musicImageView.layer.cornerRadius = musicImageView.bounds.height / 2
        musicNameLabel.textColor = UIColor.white
    }
}

