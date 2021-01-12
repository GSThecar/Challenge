//
//  AddAlarmView.swift
//  MyAlarm
//
//  Created by 이덕화 on 16/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AddAlarmView: UIView {
    weak var alarmListViewController: AlarmListViewController?
    private let identifier: String = "AddAlarmView"
    @IBOutlet weak var quickAlarm: UIButton!
    @IBOutlet weak var alarm: UIButton!
    @IBOutlet weak var close: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInitialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInitialize()
    }
    
    @IBAction func addQuicAlarm(_ sender: Any) {
        let setQuickView = SetQuickAlarmView(frame: self.bounds)
        setQuickView.alarmListViewController = alarmListViewController
        self.isHidden = true
        alarmListViewController?.navigationController?.navigationBar.isHidden = self.isHidden
        alarmListViewController?.tabBarController?.tabBar.isHidden = self.isHidden
        alarmListViewController?.view.addSubview(setQuickView)
        self.removeFromSuperview()
    }
    
    @IBAction func addAlarm(_ sender: Any) {
        let setAlarmView = SetAlarmView(frame: self.bounds)
        setAlarmView.alarmListViewController = alarmListViewController
        self.isHidden = true
        alarmListViewController?.navigationController?.navigationBar.isHidden = self.isHidden
        alarmListViewController?.tabBarController?.tabBar.isHidden = self.isHidden
        alarmListViewController?.view.addSubview(setAlarmView)
    }
    @IBAction func cancle(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    func commonInitialize() {
        if let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
            quickAlarm.layer.cornerRadius = quickAlarm.frame.height / 2
            alarm.layer.cornerRadius = quickAlarm.layer.cornerRadius
            close.layer.cornerRadius = quickAlarm.layer.cornerRadius
        }
    }
    
}
