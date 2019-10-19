//
//  SetQuickAlarm.swift
//  MyAlarm
//
//  Created by 이덕화 on 21/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class SetQuickAlarmView: UIView {

    weak var vc: AlarmListViewController?
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInitialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInitialize()
    }
    
    func commonInitialize() {
        if let view = Bundle.main.loadNibNamed("SetQuickAlarmView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    @IBAction func plus1m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        let result = Int(resultStr) ?? 0
        resultLabel.text = "\(result + 1)"
    }
    
    @IBAction func plus5m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        let result = Int(resultStr) ?? 0
        resultLabel.text = "\(result + 5)"
    }
    @IBAction func plus10m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        let result = Int(resultStr) ?? 0
        resultLabel.text = "\(result + 10)"
    }
    @IBAction func plus15m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        let result = Int(resultStr) ?? 0
        resultLabel.text = "\(result + 15)"
    }
    @IBAction func plus30m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        let result = Int(resultStr) ?? 0
        resultLabel.text = "\(result + 30)"
    }
    @IBAction func plus60m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        let result = Int(resultStr) ?? 0
        resultLabel.text = "\(result + 60)"
    }
    
    @IBAction func reset(_ sender: Any) {
        resultLabel.text! = "0"
    }
    
    @IBAction func setAndSave(_ sender: Any) {
        guard let resultStr = resultLabel.text, let result = Double(resultStr) else { return }
        guard result != 0 else { return }
        
        let date = Date(timeIntervalSinceNow: result * 60 )
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "The alarm ⏰ is going off! Wake up!"
        let soundName = UNNotificationSoundName(rawValue: "Sunshine_1.mp3")
        let sound = UNNotificationSound(named: soundName)
        content.sound = sound
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: result * 60, repeats: false)
        let request = UNNotificationRequest(identifier: "Quick", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Quick Set Done")
            }
        }

        let newAlarm = Alarm()
        newAlarm.name = "Quick"
        newAlarm.alarm = date
        let realm = try! Realm()
       try! realm.write {
            realm.add(newAlarm)
        }
        vc?.alarmListTableView.reloadData()
        close(sender)
    }
    
    @IBAction func close(_ sender: Any) {
        removeFromSuperview()
        vc?.navigationController?.navigationBar.isHidden = false
        vc?.tabBarController?.tabBar.isHidden = false
    }
}
