//
//  Model.swift
//  MyAlarm
//
//  Created by 이덕화 on 14/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import Foundation
import RealmSwift

class Alarm: Object {
    @objc dynamic var alarm: Date?
}

