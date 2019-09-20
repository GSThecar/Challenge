//
//  SetAlarm.swift
//  MyAlarm
//
//  Created by 이덕화 on 19/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import RealmSwift

class SetAlarmView: UIView {
    var vc : AlarmListViewController?
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInitialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInitialize()
    }
    

    @IBAction func close(_ sender: Any) {
        removeFromSuperview()
        vc?.navigationController?.navigationBar.isHidden = false
        vc?.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func setAndSave(_ sender: Any) {
        let newAlarm = Alarm()
        newAlarm.alarm = datePickerView.date
        let realm = try! Realm()
        try! realm.write {
            realm.add(newAlarm)
        }
        vc?.alarmListTableView.reloadData()
        close(sender)
    }
    func commonInitialize() {
        if let view = Bundle.main.loadNibNamed("SetAlarmView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
