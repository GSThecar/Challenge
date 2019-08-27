//
//  DataManager+Alarm.swift
//  Alarm
//
//  Created by 이덕화 on 26/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import Foundation
import CoreData

extension DataManager {
    func addAlarm(content: String) -> AlarmEntity {
        let newAlarm = AlarmEntity(context: context)
        
        return newAlarm
    }
}
