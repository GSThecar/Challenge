//
//  SetAlarmViewController.swift
//  Alarm
//
//  Created by 이덕화 on 28/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let newAlarmDidInsert = Notification.Name(rawValue: "newAlarmDidInsert")
    static let alarmDidUpdate = Notification.Name(rawValue: "alarmDidUpdate")
}

class SetAlarmViewController: CommonViewController {
    
    let meridiems = ["AM","PM"]
    let hours = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    let minutes: [String] = {
        return (00...59).map{"\($0)"}
    }()

    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBOutlet weak var datePickerView: UIDatePicker!

    @IBAction func done(_ sender: Any) {
        let hourRow = timePicker.selectedRow(inComponent: 0)
        let minuteRow = timePicker.selectedRow(inComponent: 1)
        let meridiemRow = timePicker.selectedRow(inComponent: 2)
        
        let hour = hours[hourRow % hours.count]
        let minute = minutes[minuteRow % minutes.count]
        let meridiem = meridiems[meridiemRow]
        
        //store alarm
        let newAlarm = DataManager.shared.addAlarm(identifier: "Alarm", meridiem: meridiem, hour: hour, minute: minute)
        
        NotificationCenter.default.post(name: .newAlarmDidInsert, object: nil, userInfo: ["Alarm": newAlarm])
        
        //set local notification
        
        switch meridiem {
        case "AM":
            let hourInt = Int(hour)
            let minuteInt = Int(minute)
            DataManager.shared.setAlarm(hour: hourInt, minute: minuteInt, weekday: 0)
        case "PM":
            let hourInt = Int(hour) ?? 0
            let resultHour = 12 + hourInt
            let minuteInt = Int(minute)
            DataManager.shared.setAlarm(hour: resultHour, minute: minuteInt, weekday: 0)
        default:
            break
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hourIndex = Int(arc4random_uniform(UInt32(hours.count))) + hours.count
        let minuteIndex = Int(arc4random_uniform(UInt32(minutes.count))) + minutes.count
        timePicker.selectRow(hourIndex, inComponent: 0, animated: true)
        timePicker.selectRow(minuteIndex, inComponent: 1, animated: true)
        
    }
    
}

extension SetAlarmViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count * 3
        case 1:
            return minutes.count * 3
        case 2:
            return meridiems.count
        default:
            return 0
        }
    }
    
    
}
extension SetAlarmViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hours[row % hours.count]
        case 1:
            return minutes[row % minutes.count]
        case 2:
            return meridiems[row]
        default:
            return nil
        }
    }
    
}
