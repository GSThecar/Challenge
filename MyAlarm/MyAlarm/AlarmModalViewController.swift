//
//  AlarmModalViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 06/10/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import AVFoundation

class AlarmModalViewController: UIViewController {

    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_kr")
        return f
    }()
    
    var player: AVPlayer?
    
   @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = Bundle.main.path(forResource: "Sunshine", ofType: "mp3") else { return }
        self.player = AVPlayer(url: URL(fileURLWithPath: path))
        self.player?.play()
        
        let image = UIImage(named: "DumbBack")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        guard let superView = self.view else { return }
        
        let date = Date()
        let dateLabel = UILabel()
        formatter.dateStyle = .full
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor.white
        dateLabel.text = formatter.string(from: date)
        
        let timeLabel = UILabel()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        timeLabel.textAlignment = dateLabel.textAlignment
        timeLabel.textColor = dateLabel.textColor
        timeLabel.font = .boldSystemFont(ofSize: 60)
        timeLabel.text = formatter.string(from: date)
        
        let removeButton = UIButton()
        removeButton.setTitle("Dismiss", for: .normal)
        removeButton.titleLabel?.textColor = timeLabel.textColor
        removeButton.backgroundColor = UIColor.blue
        removeButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        
        superView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let top0Constraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0)
        let bottom0Constraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: 0)
        let leading0Constraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing0Constraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1, constant: 0)
        superView.addConstraints([top0Constraint, bottom0Constraint, leading0Constraint, trailing0Constraint])
        
        superView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let top60Constraint = NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .top, multiplier: 1, constant: 60)
        let leading15Constraint = NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: imageView, attribute: .leading, multiplier: 1, constant: 15)
        let trailing15Constraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: dateLabel, attribute: .trailing, multiplier: 1, constant: 15)
        superView.addConstraints([top60Constraint, leading15Constraint, trailing15Constraint])
        
        superView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let sameLeadingConstraint = NSLayoutConstraint(item: timeLabel, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .leading, multiplier: 1, constant: 0)
        let betweenLabelsConstraint = NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 20)
        superView.addConstraints([sameLeadingConstraint, betweenLabelsConstraint])
    
        superView.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        let bottom15Constraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: removeButton, attribute: .bottom, multiplier: 1, constant: 15)
        let equalLeading = NSLayoutConstraint(item: removeButton, attribute: .leading, relatedBy: .equal, toItem: timeLabel, attribute: .leading, multiplier: 1, constant: 0)
        let equalTrailing = NSLayoutConstraint(item: removeButton, attribute: .trailing, relatedBy: .equal, toItem: dateLabel, attribute: .trailing, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: removeButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        superView.addConstraints([bottom15Constraint, equalLeading, equalTrailing, height])
        
//        let musicUrl = URL(fileURLWithPath: "Sunshine.mp3")
//            do {
//                let player = try AVAudioPlayer(contentsOf: <#T##URL#>, fileTypeHint: "mp3")
//                player.numberOfLoops = 100
//                player.play()
//
//            }
//            catch {
//                print(error.localizedDescription)
//            }
            
        
        
        
        // Do any additional setup after loading the view.
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
