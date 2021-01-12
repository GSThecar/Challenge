//
//  Alarm.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/01/12.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation
import RealmSwift

class Alarm: Object {
    //v0
    @objc dynamic var alarm: Date = Date()
    //v1 : add 1more
    @objc dynamic var name: String = ""
    //v2 : add 1more
    @objc dynamic var repeatStatus: Bool = false
}
