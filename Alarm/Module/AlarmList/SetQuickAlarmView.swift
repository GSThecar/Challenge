//
//  SetQuickAlarmViewController.swift
//  Alarm
//
//  Created by 이덕화 on 30/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class SetQuickAlarmView: UIView {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var btn1m: UIButton!
    @IBOutlet weak var btn5m: UIButton!
    @IBOutlet weak var btn10m: UIButton!
    @IBOutlet weak var btn15m: UIButton!
    @IBOutlet weak var btn30m: UIButton!
    @IBOutlet weak var btn1h: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var btnVibration: UIButton!
    
    
    
    @IBAction func plus1m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        var result = Int(resultStr) ?? 0
        result += 1
        resultLabel.text = "\(result)"
    }
    
    @IBAction func plus5m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        var result = Int(resultStr) ?? 0
        result += 15
        resultLabel.text = "\(result)"
    }
    
    @IBAction func plus10m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        var result = Int(resultStr) ?? 0
        result += 10
        resultLabel.text = "\(result)"
    }
    
    @IBAction func plus15m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        var result = Int(resultStr) ?? 0
        result += 15
        resultLabel.text = "\(result)"
    }
    
    @IBAction func plus30m(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        var result = Int(resultStr) ?? 0
        result += 30
        resultLabel.text = "\(result)"
    }
    
    @IBAction func plus1h(_ sender: Any) {
        guard let resultStr = resultLabel.text else { return }
        var result = Int(resultStr) ?? 0
        result += 60
        resultLabel.text = "\(result)"
    }
    
    @IBAction func close(_ sender: Any) {
        
    }
    @IBAction func saveQuickAlarm(_ sender: Any) {
        guard let minutesStr = resultLabel.text else { return }
        let minutes = Double(minutesStr) ?? 0.0
        DataManager.shared.setQuickAlarm(timeInterver: minutes)
    }
    
    @IBAction func reset(_ sender: Any) {
        resultLabel.text = "0"
    }
    @IBAction func soundOnOff(_ sender: Any) {
    }
    
    @IBAction func vibrationOnOff(_ sender: Any) {
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    func commonInitialization() {
        if let view = Bundle.main.loadNibNamed("SetQuickAlarmView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
            btn1h.layer.cornerRadius = btn1h.frame.height / 2
            btn5m.layer.cornerRadius = btn1h.layer.cornerRadius
            btn10m.layer.cornerRadius = btn1h.layer.cornerRadius
            btn15m.layer.cornerRadius = btn1h.layer.cornerRadius
            btn30m.layer.cornerRadius = btn1h.layer.cornerRadius
            btn1m.layer.cornerRadius = btn1h.layer.cornerRadius
            btnReset.layer.cornerRadius = btn1h.layer.cornerRadius
            btnDone.layer.cornerRadius = btnDone.frame.height / 2
            btnSound.layer.cornerRadius = btnSound.frame.height / 2
            btnVibration.layer.cornerRadius = btnSound.layer.cornerRadius
        }
    }
    
    deinit {
        print(self, #function)
    }
    
}

