//
//  AlarmListViewController.swift
//  Alarm
//
//  Created by 이덕화 on 23/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListViewController: CommonViewController {
    
    @IBOutlet weak var setAlarmStackView: UIStackView!
    @IBOutlet weak var addAlarmButton: UIButton!
    @IBOutlet weak var alarmListTableView: UITableView!
    @IBOutlet weak var setQuickAlarmStackView: UIStackView!

    
     var list = ["11:00", "22:00", "33:00", "44:00", "55:00" ,"11:00", "22:00", "33:00", "44:00", "55:00"]
    
    
    
    @IBAction func addAlarm(_ sender: Any) {
        setAlarmStackView.isHidden = false
        setQuickAlarmStackView.isHidden = false
    }
    @IBAction func quickSet(_ sender: Any) {
        let view = SetQuickAlarmView(frame: self.view.frame)
        self.view.addSubview(view)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    deinit {
        print(self, #function)
    }
    
    
    //@IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        addAlarmButton.layer.cornerRadius = addAlarmButton.frame.height / 2
        alarmListTableView.backgroundColor = alarmListTableView.tableHeaderView?.backgroundColor
        navigationController?.navigationBar.transparentNavigationBar()
        tabBarController?.tabBar.transparentTabBar()
        setAlarmStackView.isHidden = true
        setQuickAlarmStackView.isHidden = true
    }
    
    
    
}
extension AlarmListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return list.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RemainTimeTableViewCell.identifier, for: indexPath) as! RemainTimeTableViewCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.identifier, for: indexPath) as! AlarmListTableViewCell
            let target = list[indexPath.row]
            cell.timeLabel.text = "\(target)"
            return cell
        default:
            fatalError("Invalid section")
        }
    }
    
}


