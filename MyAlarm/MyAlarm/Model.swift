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
    //v0
    @objc dynamic var alarm: Date?
    //v1 : add 1more
    @objc dynamic var name: String?
}



//let dropBoxToken = "ZzXIFEHKkAAAAAAAAAAAF-tuGvovER9D5PgC3R-2eqgvH8AJywEAPLRRNTlD3xh6"
