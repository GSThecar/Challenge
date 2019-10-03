//
//  TodayInformationTableViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 20/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit


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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        WeatherData.shared.fetchLocation(lat: 37.498206, lon: 127.02761) { [weak self] in
            self?.tableView.reloadData()
        }
        WeatherData.shared.fetchWeather(locationKey: "1849823") { [weak self] in
            self?.tableView.reloadData()
        }
        WeatherData.shared.fetchForecast(locationKey: "1849823") { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
