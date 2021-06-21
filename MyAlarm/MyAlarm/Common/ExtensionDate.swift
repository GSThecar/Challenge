//
//  ExtensionDate.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
