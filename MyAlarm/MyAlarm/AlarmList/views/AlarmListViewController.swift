//
//  AlarmViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 14/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import CoreLocation

class AlarmListViewController: UIViewController, BasicViewType {
    typealias PresenterType = AlarmListPresenter
    
    var presenter: PresenterType
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = self
        return m
    }()
    
    @IBOutlet weak var alarmListTableView: UITableView!
    
    @IBOutlet weak var addAlarm: UIButton!
    
    @IBOutlet weak var noAlarmStackView: UIStackView!
    
    private let tableView: UITableView = {
        return UITableView()
    }()
    
    @IBAction func addAlarm(_ sender: Any) {
        let view = AddAlarmView(frame: self.view.frame)
        view.alarmListViewController = self
        self.view.addSubview(view)
    }
    
    init(with presenter: PresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        let image = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = image
        self.navigationController?.navigationBar.isTranslucent = true
        
        alarmListTableView.backgroundColor = UIColor.clear
        
        let nib = UINib(nibName: AlarmListTableViewCell.reuseIdentifier, bundle: nil)
        alarmListTableView.register(nib, forCellReuseIdentifier: AlarmListTableViewCell.reuseIdentifier)
        
        addAlarm.layer.cornerRadius = addAlarm.frame.height / 2
        
//        let realm = try! Realm()
        
//        list = realm.objects(Alarm.self)
        
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
    
    private func updateNoAlarmStackView() {
        let show: CGFloat = 1
        let hide: CGFloat = 0
        noAlarmStackView.alpha = presenter.getAlarms().count == .zero ? show : hide
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateNoAlarmStackView()
        return presenter.getAlarms().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.reuseIdentifier, for: indexPath) as! AlarmListTableViewCell
        
        cell.update(alarm: presenter.getAlarms()[indexPath.row]) 
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.reuseIdentifier, for: indexPath) as! AlarmListTableViewCell
//            if let list = list {
//                let target = list[indexPath.row]
//                cell.timeLabel.text = dateFormatter.string(for: target.alarm)
//
//                
//            }
//            return cell
//        default:
//            fatalError()
//        }
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
//        guard editingStyle == .delete, let target = list?[indexPath.row] else { return }
//
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [target.name])
//
//        let realm = try! Realm()
//        try! realm.write {
//            realm.delete(target)
//        }
//        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension AlarmListViewController: CLLocationManagerDelegate {
    func updateCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            WeatherData.shared.fetchLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) {
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
