//
//  CityVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class NetworkManagerVC {
    public static let sharedInstance: NetworkManagerVC = NetworkManagerVC()
    
    class func fetchCityDetailsByLocation(url: String, onSuccess: @escaping (CityModel) -> Void, onFailure: @escaping APIErrorHandler) {

        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! NSDictionary
//                print(responseObject)
//                print("\(responseObject.value(forKeyPath: "main.temp") ?? "" )")
//                print("\(responseObject.value(forKeyPath: "main.humidity") ?? "" )")
//                print(responseObject.value(forKeyPath: "weather.description" ) as! Array<String>)
//                print("\(responseObject?.value(forKeyPath: "wind.speed") ?? "" )")
//                print("\(responseObject?.value(forKeyPath: "wind.deg") ?? "" )")
//
                let temperatureStr = "\(responseObject.value(forKeyPath: "main.temp") ?? "" )"
                let humidityStr = "\(responseObject.value(forKeyPath: "main.humidity") ?? "" )"
                var rainyArr = responseObject.value(forKeyPath: "weather.description" ) as! Array<String>
                let speedStr = "\(responseObject.value(forKeyPath: "wind.speed") ?? "" )"
                let degStr = "\(responseObject.value(forKeyPath: "wind.deg") ?? "" )"

                let cityDet = CityModel(temperature: temperatureStr, humidity: humidityStr, rainChances: rainyArr[0], speed: speedStr, deg: degStr)
                onSuccess(cityDet)
            } catch {
                print("json error: \(error)")
            }
        }
        task.resume()
        
    }
    class func fetchCityDetailsByLocationFor5DaysForecast(url: String, onSuccess: @escaping (CityModel) -> Void, onFailure: @escaping APIErrorHandler) {
        
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! NSDictionary
                print(responseObject)
                let responseArr = responseObject.value(forKey: "list") as! NSArray
                print(responseArr)

                
            } catch {
                print("json error: \(error)")
            }
        }
        task.resume()
        
    }

}
