//
//  AlarmListViewController.swift
//  Alarm
//
//  Created by 이덕화 on 23/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListViewController: CommonViewController {
    
    static let shared = AlarmListViewController()
    @IBOutlet weak var setAlarmStackView: UIStackView!
    @IBOutlet weak var addAlarmButton: UIButton!
    @IBOutlet weak var alarmListTableView: UITableView!
    @IBOutlet weak var setQuickAlarmStackView: UIStackView!
    
    
    var list = [AlarmEntity]()

    
    
    @IBAction func addAlarm(_ sender: Any) {
        switch setAlarmStackView.isHidden {
        case true:
            setAlarmStackView.isHidden = false
            setQuickAlarmStackView.isHidden = setAlarmStackView.isHidden
        case false:
            setAlarmStackView.isHidden = true
            setQuickAlarmStackView.isHidden = setAlarmStackView.isHidden
        }
        
    }
    @IBAction func quickSet(_ sender: Any) {
        let view = SetQuickAlarmView(frame: self.view.frame)
        self.view.addSubview(view)
        tabBarController?.tabBar.isHidden = true
        setAlarmStackView.isHidden = true
        setQuickAlarmStackView.isHidden = true
    }
    
    @IBAction func alarmSet(_ sender: Any) {
        setAlarmStackView.isHidden = true
        setQuickAlarmStackView.isHidden = setAlarmStackView.isHidden
        setAlarmStackView.isHidden = true
        setQuickAlarmStackView.isHidden = true
    }
    
    deinit {
        print(self, #function)
    }
    
    var topInset: CGFloat = 0.0
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if topInset == 0 {
            guard let naviBarheight = navigationController?.navigationBar.frame.height else { return }
            topInset = naviBarheight
            alarmListTableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        }
        let indexpath = IndexPath(row: 0, section: 2)
        let cell = alarmListTableView.cellForRow(at: indexpath) as! AlarmListTableViewCell
        
        print(cell.timeStatusBarView.frame)
        print(cell.repeatStatusBarView.frame)
        
    }
    
    override func viewDidLoad() {
        
        addAlarmButton.layer.cornerRadius = addAlarmButton.frame.height / 2
        alarmListTableView.backgroundColor = alarmListTableView.tableHeaderView?.backgroundColor
        navigationController?.navigationBar.transparentNavigationBar()
        tabBarController?.tabBar.transparentTabBar()
        
        setAlarmStackView.isHidden = true
        setQuickAlarmStackView.isHidden = true
        
        list = DataManager.shared.fetchAlarm()
        
        addObserver(name: .newAlarmDidInsert) { (alarm) in
            self.list.insert(alarm, at: 0)
            let firstIndexPath = IndexPath(row: 0, section: 2)
            self.alarmListTableView.insertRows(at: [firstIndexPath], with: .automatic)
        }
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
            guard let hour = target.hour, let minute = target.minute else {
                cell.timeLabel.text = "Invalid Time"
                
                return cell
            }
            cell.timeLabel.text = hour + ":" + minute
            cell.meridiemLabel.text = target.meridiem
            
            return cell
        default:
            fatalError("Invalid section")
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let target = list.remove(at: indexPath.row)
            DataManager.shared.delete(alarm: target)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
}


