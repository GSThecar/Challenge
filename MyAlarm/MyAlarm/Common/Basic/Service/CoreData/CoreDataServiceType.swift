//
//  CoreDataServiceType.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation

protocol CoreDataServiceType: BasicServiceType {
    var entityName: String { get }
}
