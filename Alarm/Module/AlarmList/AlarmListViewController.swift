//
//  AlarmListViewController.swift
//  Alarm
//
//  Created by 이덕화 on 23/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListViewController: CommonViewController {
    
    var list = [1, 2, 3, 4, 5 ,6 ,7 ,8 ,9 ,10, 1, 2, 3, 4, 5 ,6 ,7 ,8 ,9 ,10]
    
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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.identifier, for: indexPath) as! AlarmListTableViewCell
        cell.testlabel.text = "\(target)"
        return cell
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
