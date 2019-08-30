//
//  SetAlarmViewController.swift
//  Alarm
//
//  Created by 이덕화 on 28/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class SetAlarmViewController: CommonViewController {
    
    let meridiem = ["AM","PM"]
    let hours = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    let minutes: [String] = {
        return (0...59).map{"\($0)"}
    }()
    
    @IBOutlet weak var timePicker: UIPickerView!
    
    
    @IBAction func saveAlarm(_ sender: Any) {
        //DataManager.shared.setAlarm()
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
            return meridiem.count
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
            return meridiem[row]
        default:
            return nil
        }
    }
}
