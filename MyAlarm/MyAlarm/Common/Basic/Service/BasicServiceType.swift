//
//  BasicServiceType.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation

protocol BasicServiceType {
    associatedtype ManagerType
    var manager: ManagerType { get }
}
