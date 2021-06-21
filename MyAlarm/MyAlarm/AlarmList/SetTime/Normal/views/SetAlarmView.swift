//
//  SetAlarm.swift
//  MyAlarm
//
//  Created by 이덕화 on 19/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import UserNotifications

class SetAlarmView: UIView {
    weak var alarmListViewController : AlarmListViewController?
    private let identifier: String = "SetAlarmView"
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
        alarmListViewController?.navigationController?.navigationBar.isHidden = false
        alarmListViewController?.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func setAndSave(_ sender: Any) {
        //TODO: 알람설정
//        let newAlarm = Alarm()
//        newAlarm.alarm = datePickerView.date
//        newAlarm.repeatStatus = repeatSwitch.isOn
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Alarm"
//        content.body = "The alarm ⏰ is going off! Wake up!"
//        let soundName = UNNotificationSoundName(rawValue: "Sunshine_1.mp3")
//        let sound = UNNotificationSound(named: soundName)
//        content.sound = sound
//        
//        let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: datePickerView.date)
//        if repeatSwitch.isOn {
//            newAlarm.name = "Repeat Alarm"
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
//            let request = UNNotificationRequest(identifier: "Repeat Alarm", content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request) { (error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("Set Repeat Alarm Done")
//                }
//            }
//        } else {
//            newAlarm.name = "Alarm"
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
//            let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request) { (error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("Set Alarm Done")
//                }
//            }
//        }
//        
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(newAlarm)
//        }
        alarmListViewController?.alarmListTableView.reloadData()
        close(sender)
    }
    func commonInitialize() {
        if let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
