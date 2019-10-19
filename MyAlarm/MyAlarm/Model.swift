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
    @objc dynamic var alarm: Date = Date()
    //v1 : add 1more
    @objc dynamic var name: String = ""
    //v2 : add 1more
    @objc dynamic var repeatStatus: Bool = false
}



//let dropBoxToken = ""
let apiKey = "xx6RZJkByUtvInLx1vwPQ18XenCuZLLA"

struct Location: Codable {
    let key: String
    let localizedName: String
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
    }
}
struct Forecast: Codable {
    struct DailyForecasts: Codable {
        struct Temperature: Codable {
            struct Minimum: Codable {
                let value: Double
                enum CodingKeys: String, CodingKey {
                    case value = "Value"
                }
            }
            struct Maximum: Codable {
                let value: Double
                enum CodingKeys: String, CodingKey {
                    case value = "Value"
                }
            }
            let minimum: Minimum
            let maximum: Maximum
            enum CodingKeys: String, CodingKey {
                case minimum = "Minimum"
                case maximum = "Maximum"
            }
        }
        let temperature: Temperature
        enum CodingKeys: String, CodingKey {
            case temperature = "Temperature"
        }
    }
    let dailyForecasts: [DailyForecasts]
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct Weather {
    var wheatherText: String?
    var weatherIcon: Int?
    var currentTemp: Double?
    var tempDeparture: Double?
}

struct MemoList: Codable {
    struct Entries: Codable {
        let name: String
        let client_modified: String
    }
    var entries: [Entries]
}
struct ListParameter: Codable{
    let path = ""
    let recursive = false
    let include_media_info = false
    let include_deleted = false
    let include_has_explicit_shared_members = false
    let include_mounted_folders = true
    let include_non_downloadable_files = true
}
struct DeleteParameter: Codable {
    let path: String
}
