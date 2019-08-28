//
//  AlarmListViewController.swift
//  Alarm
//
//  Created by 이덕화 on 23/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListViewController: CommonViewController {
    
    var list = ["11:00", "22:00", "33:00", "44:00", "55:00" ,"11:00", "22:00", "33:00", "44:00", "55:00"]
    
    @IBOutlet weak var addAlarmButton: UIButton!
    
    @IBOutlet weak var alarmListTableView: UITableView!
    
    
    //@IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        addAlarmButton.layer.cornerRadius = addAlarmButton.frame.height / 2
        alarmListTableView.backgroundColor = UIColor.clear
        navigationController?.navigationBar.transparentNavigationBar()
        tabBarController?.tabBar.transparentTabBar()
    }
    
    
    
}
extension AlarmListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return list.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.identifier, for: indexPath) as! AlarmListTableViewCell
            let target = list[indexPath.row]
            cell.timeLabel.text = "\(target)"
            return cell
        default:
            fatalError()
        }
    }
}

extension UINavigationBar {
    func transparentNavigationBar() {
        let image = UIImage()
        self.setBackgroundImage(image, for: UIBarMetrics.default)
        self.shadowImage = image
        self.isTranslucent = true
    }
}

extension UITabBar {
    func transparentTabBar() {
        let image = UIImage()
        self.backgroundImage = image
        self.shadowImage = image
        self.isTranslucent = true
    }
}
