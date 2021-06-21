//
//  AlarmListPresenter.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation

class AlarmListPresenter: BasicPresenterType {
    typealias ServiceType = AlarmService
    typealias BasicViewType = AlarmListViewController
    
    weak var view: BasicViewType?
    var service: ServiceType
    
    init(service: ServiceType) {
        self.service = service
    }
    
    func viewDidLoad() {
        
    }
    
    func getAlarms() -> [Alarm] {
        service.getAlarms(name: .Alarm)
    }
}
