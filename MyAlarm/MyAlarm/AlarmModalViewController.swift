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
    
    var player: AVAudioPlayer?
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = Bundle.main.path(forResource: "Sunshine", ofType: "mp3"), let url = URL(string: path) else { return }
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        self.player?.play()
        
        let image = UIImage(named: "DumbBack")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
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
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        removeButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let musicUrl = URL(fileURLWithPath: "Sunshine.mp3")
        do {
            let player = try AVAudioPlayer(contentsOf: musicUrl, fileTypeHint: "mp3")
            player.numberOfLoops = 100
            player.play()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    deinit {
        print(self, #function)
    }
    
}
