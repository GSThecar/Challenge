//
//  WeatherDataSource.swift
//  MyAlarm
//
//  Created by 이덕화 on 27/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import Foundation

class WeatherData {
    static let shared = WeatherData()
    private init() {}
    
    var location: Location?
    var weather: Weather?
    var forecast: Forecast?
    
    func fetchLocation(lat: Double, lon: Double, completion: @escaping () -> () ) {
        let locURLStr = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(apiKey)&q=\(lat),\(lon)&language=ko&details=false&toplevel=false"
        guard let locURL = URL(string: locURLStr) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: locURL) { [weak self] (data, response, error) in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print(httpResponse.statusCode)
                return
            }
            
            guard let data = data else {
                print("Invalid Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                self?.location = try decoder.decode(Location.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchWeather( locationKey: String ,completion: @escaping () -> () ) {
        let weatherURLStr = "https://dataservice.accuweather.com/currentconditions/v1/\(locationKey)?apikey=\(apiKey)&language=ko&details=true"
        guard let locURL = URL(string: weatherURLStr) else {
            print("Invalid URL")
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: locURL) { [weak self] (data, response, error) in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print(httpResponse.statusCode)
                return
            }
            
            guard let data = data else {
                print("Invalid DATA")
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
                self?.weather = weather
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchForecast( locationKey: String ,completion: @escaping () -> () ) {
        let locURLStr = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(locationKey)?apikey=xx6RZJkByUtvInLx1vwPQ18XenCuZLLA&language=ko&details=false&metric=true"
        
        
        let locURL = URL(string: locURLStr)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: locURL) { (data, response, error) in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print(httpResponse.statusCode)
                return
            }
            
            guard let data = data else {
                print("Invalid Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                self.forecast = try decoder.decode(Forecast.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

