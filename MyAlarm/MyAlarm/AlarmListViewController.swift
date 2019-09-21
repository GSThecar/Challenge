//
//  AlarmViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 14/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import RealmSwift

class AlarmListViewController: UIViewController {
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.timeStyle = .short
        return f
    }()
    
    var list: Results<Alarm>?
    
    @IBOutlet weak var alarmListTableView: UITableView!
    
    @IBOutlet weak var addAlarm: UIButton!
    
    
    @IBAction func addAlarm(_ sender: Any) {
        let view = AddAlarmView(frame: self.view.frame)
        view.vc = self
        self.view.addSubview(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = image
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.tabBar.backgroundImage = image
        self.tabBarController?.tabBar.shadowImage = image
        self.tabBarController?.tabBar.isTranslucent = true
        
        alarmListTableView.backgroundColor = UIColor.clear
        
        let nib = UINib(nibName: AlarmListTableViewCell.identifier, bundle: nil)
        alarmListTableView.register(nib, forCellReuseIdentifier: AlarmListTableViewCell.identifier)
        
        addAlarm.layer.cornerRadius = addAlarm.frame.height / 2
        // Do any additional setup after loading the view.
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        list = realm.objects(Alarm.self)
    }
    
}
extension AlarmListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let list = list else { return 0}
            return list.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.identifier, for: indexPath) as! AlarmListTableViewCell
            if let list = list {
                let target = list[indexPath.row]
                cell.timeLabel.text = dateFormatter.string(for: target.alarm)
                if let name = target.name {
                    switch name {
                    case "Alarm":
                        cell.alarmImageView.image = UIImage(named: "filled_icon-navi-01-dis.1_Normal", in: .main, compatibleWith: nil)
                    default:
                        cell.alarmImageView.image = UIImage(named: "IconQuickAlarm_Normal", in: .main, compatibleWith: nil)
                    }
                }
            }
            return cell
        default:
            fatalError()
        }
    }
}

extension AlarmListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        if let target = list?[indexPath.row] {
            let realm = try! Realm()
           try! realm.write {
                realm.delete(target)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
}

