//
//  AlarmViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 14/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class AlarmListViewController: UIViewController {
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.timeStyle = .short
        return f
    }()
    
    var list: Results<Alarm>?
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = self
        return m
    }()
    
    @IBOutlet weak var alarmListTableView: UITableView!
    
    @IBOutlet weak var addAlarm: UIButton!
    
    @IBOutlet weak var noAlarmStackView: UIStackView!
    
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
        
        alarmListTableView.backgroundColor = UIColor.clear
        
        let nib = UINib(nibName: AlarmListTableViewCell.identifier, bundle: nil)
        alarmListTableView.register(nib, forCellReuseIdentifier: AlarmListTableViewCell.identifier)
        
        addAlarm.layer.cornerRadius = addAlarm.frame.height / 2
        // Do any additional setup after loading the view.
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        list = realm.objects(Alarm.self)
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                updateCurrentLocation()
            case .denied, .restricted:
                show(message: "위치서비스 사용불가")
            default:
                break
            }
        } else {
            show(message: "위치 사용 불가")
        }
    }
    deinit {
        print(self, #function)
    }
}
extension AlarmListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let list = list else { return 0 }
            if list.count == 0 {
                self.noAlarmStackView.alpha = 1
            } else if list.count == 1 {
                self.noAlarmStackView.alpha = 0
            }
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
                
                switch target.name {
                case "Quick":
                    cell.alarmImageView.image = UIImage(named: "IconQuickAlarm_Normal", in: .main, compatibleWith: nil)
                    cell.repeatStatusStackView.alpha = 0
                case "Alarm":
                    cell.alarmImageView.image = UIImage(named: "filled_icon-navi-01-dis.1_Normal", in: .main, compatibleWith: nil)
                    cell.repeatStatusStackView.alpha = 0
                default:
                    cell.alarmImageView.image = UIImage(named: "filled_icon-navi-01-dis.1_Normal", in: .main, compatibleWith: nil)
                    cell.repeatStatusStackView.alpha = 1
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
        guard editingStyle == .delete, let target = list?[indexPath.row] else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [target.name])
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(target)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        
    }
}

extension AlarmListViewController: CLLocationManagerDelegate {
    func updateCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            WeatherData.shared.fetchLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude) {
                print(location)
            }
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            updateCurrentLocation()
        default:
            break
        }
    }
    
}
