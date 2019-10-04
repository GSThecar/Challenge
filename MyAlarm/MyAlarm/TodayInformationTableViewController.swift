//
//  TodayInformationTableViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 20/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import CoreLocation

extension UIViewController {
    func show(message: String) {
        let alert = UIAlertController.init(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
class TodayInformationTableViewController: UITableViewController {
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .full
        f.dateFormat = "MMM d일 EEEE"
        f.locale = Locale(identifier: "ko_kr")
        return f
    }()
    let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let locationKey = WeatherData.shared.location?.key else { return }
        WeatherData.shared.fetch(locationKey: locationKey) {
            self.tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            let date = Date()
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
            
            cell.textLabel?.text = "오늘의 패널"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
            if let imageNo = WeatherData.shared.weather?.weatherIcon {
                let image = UIImage(named: "WeatherFilledColor\(imageNo)_Normal")
                cell.weatherImageView.image = image
            }
            
            if let localName = WeatherData.shared.location?.localizedName {
                if let weatherText = WeatherData.shared.weather?.wheatherText {
                    cell.localAndStatusLabel.text = localName + ", " + weatherText
                }
            }
            
            let currentTemp = WeatherData.shared.weather?.currentTemp
            if let tempStr = numberFormatter.string(for: currentTemp) {
                cell.currentTemperatureLabel.text = "\(tempStr)º"
            }
            
            let maxTemp = WeatherData.shared.forecast?.dailyForecasts.first?.temperature.maximum.value
            let minTemp = WeatherData.shared.forecast?.dailyForecasts.first?.temperature.minimum.value
            if let maxStr = numberFormatter.string(for: maxTemp) , let minStr = numberFormatter.string(for: minTemp) {
                cell.maxMinLabel.text = "\(maxStr)º↑ \(minStr)º↓"
            }
            
            if let departure = WeatherData.shared.weather?.tempDeparture {
                if departure == 0 {
                    cell.compareLabel.text = "어제와 같음"
                } else if departure > 0 {
                    cell.compareLabel.text = "어제보다 높음"
                } else {
                    cell.compareLabel.text = "어제보다 낮음"
                }
            }
            
            return cell
            
        default:
            fatalError("Inavalid Cell")
        }
    }
    
}
