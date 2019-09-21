//
//  SetAlarm.swift
//  MyAlarm
//
//  Created by 이덕화 on 19/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class SetAlarmView: UIView {
    weak var vc : AlarmListViewController?
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBOutlet weak var repeatSwitch: UISwitch!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInitialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInitialize()
    }
    

    @IBAction func close(_ sender: Any) {
        removeFromSuperview()
        vc?.navigationController?.navigationBar.isHidden = false
        vc?.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func setAndSave(_ sender: Any) {
        let newAlarm = Alarm()
        newAlarm.name = "Alarm"
        newAlarm.alarm = datePickerView.date
        //set
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "The alarm ⏰ is going off! Wake up!"
        content.sound = .none

        let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: datePickerView.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: repeatSwitch.isOn)
        let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Set Alarm Done")
            }
        }
        //save
        let realm = try! Realm()
        try! realm.write {
            realm.add(newAlarm)
        }
        vc?.alarmListTableView.reloadData()
        close(sender)
    }
    func commonInitialize() {
        if let view = Bundle.main.loadNibNamed("SetAlarmView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
