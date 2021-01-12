//
//  SleepMusicCollectionViewCell.swift
//  MyAlarm
//
//  Created by 이덕화 on 23/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class SleepMusicCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SleepMusicCollectionViewCell"
    
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var musicNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        indicator.color = UIColor.white
        musicImageView.layer.cornerRadius = musicImageView.bounds.height / 2
        musicNameLabel.textColor = UIColor.white
    }
}

