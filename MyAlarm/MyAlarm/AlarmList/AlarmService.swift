//
//  AlarmService.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation

class AlarmService: BasicServiceType  {
    typealias ManagerType = CoreDataManager
    var manager: ManagerType
    enum EntityName: String {
        case Alarm
        case Quick
    }
    init(manager: ManagerType) {
        self.manager = manager
    }
    
    func getAlarms(name: EntityName) -> [Alarm] {
        fetch(entity: name.rawValue)
    }
    
    private func fetch(entity name: String) -> [Alarm] {
        manager.fetch(entity: name).compactMap { $0 as? Alarm }
    }
    
}
