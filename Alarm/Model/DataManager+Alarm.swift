//
//  DataManager+Alarm.swift
//  Alarm
//
//  Created by 이덕화 on 26/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

extension DataManager {
    func addAlarm(content: String) -> AlarmEntity {
        let newAlarm = AlarmEntity(context: context)
        
        return newAlarm
    }
    func fetchAlarm() -> [AlarmEntity] {
        let request: NSFetchRequest<AlarmEntity> = AlarmEntity.fetchRequest()
        
        do {
           return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return [AlarmEntity]()
        }
    }
    func setQuickAlarm(timeInterver minutes: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "The alarm ⏰ is going off! Wake up!"
        content.sound = .none
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: minutes * 60, repeats: false)
        let request = UNNotificationRequest(identifier: "QuickAlarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Done")
            }
        }
    }
    func setAlarm() {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "The alarm ⏰ is going off! Wake up!"
        content.sound = .none
        let dateComponents = DateComponents()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Done")
            }
        }
    }
}
