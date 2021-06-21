//
//  TabBarPresenter.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation

class TabBarPresenter {
    weak var view: TabBarController?
    
    func viewDidLoad() {
        view?.setUpTabs(with: AlarmListPresenter(service: AlarmService(manager: CoreDataManager())))
    }
}
