//
//  WeatherDataSource.swift
//  MyAlarm
//
//  Created by 이덕화 on 27/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class WeatherData {
    static let shared = WeatherData()
    private init() {}
    
    var location: Location?
    var weather: Weather?
    var forecast: Forecast?
    
    let group = DispatchGroup()
    let workQueue = DispatchQueue(label: "apiQueue", attributes: .concurrent)
    
    func fetch( locationKey: String, completion: @escaping () -> () ) {
        group.enter()
        workQueue.async {
            self.fetchWeather(locationKey: locationKey, completion: {
                self.group.leave()
            })
        }
        group.enter()
        workQueue.async {
            self.fetchForecast(locationKey: locationKey, completion: {
                self.group.leave()
            })
        }
        group.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    func fetchLocation( latitude: Double, longitude: Double, completion: @escaping () -> () ) {
        let locURLStr = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(apiKey)&q=\(latitude),\(longitude)&language=ko&details=false&toplevel=false"
        
        AF.request(locURLStr, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil, interceptor: nil).validate(statusCode: 200..<300).responseData { (response) in
            if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    self.location = try decoder.decode(Location.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion()
        }
    }
    
    func fetchWeather( locationKey: String ,completion: @escaping () -> () ) {
        let weatherURLStr = "https://dataservice.accuweather.com/currentconditions/v1/\(locationKey)?apikey=\(apiKey)&language=ko&details=true"
        AF.request(weatherURLStr, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil, interceptor: nil).validate(statusCode: 200..<300).responseData { (response) in
            guard let data = response.data else {
                print("Invalid Data")
                return
            }
            do {
                guard let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String:Any]] else { return }
                var weather = Weather()
                let text = jsonArray.map{$0["WeatherText"]}[0] as? String
                weather.wheatherText = text
                let code = jsonArray.map{$0["WeatherIcon"]}[0] as? Int
                weather.weatherIcon = code
                
                let temp = jsonArray.map{$0["Temperature"]}[0] as? [String:Any]
                
                if let temp = temp {
                    if let metric = temp["Metric"] as? [String:Any] {
                        let metricTemp = metric["Value"] as? Double
                        weather.currentTemp = metricTemp
                    }
                }
                
                let tempDeparture = jsonArray.map{$0["Past24HourTemperatureDeparture"]}[0] as? [String:Any]
                
                if let tempDeparture = tempDeparture {
                    if let metric = tempDeparture["Metric"] as? [String:Any] {
                        let metricTemp = metric["Value"] as? Double
                        weather.tempDeparture = metricTemp
                    }
                }
                self.weather = weather
                
            } catch {
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func fetchForecast( locationKey: String ,completion: @escaping () -> () ) {
        let forecastURLStr = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(locationKey)?apikey=xx6RZJkByUtvInLx1vwPQ18XenCuZLLA&language=ko&details=false&metric=true"
        
        AF.request(forecastURLStr, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil, interceptor: nil).validate(statusCode: 200..<300).responseJSON { (response) in
            if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    self.forecast = try decoder.decode(Forecast.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion()
        }
    }
}

