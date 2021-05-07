//
//  CityVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit
import Alamofire


class NetworkManagerVC {
    public static let sharedInstance: NetworkManagerVC = NetworkManagerVC()
    
    class func fetchCityDetailsByLocation(locLatitude: String, locLongitude: String, onSuccess: @escaping (CityModel) -> Void, onFailure: @escaping APIErrorHandler) {
        

        let urlString = String(format: "http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=fae7190d7e6433ec3a45285ffcf55c86", arguments: [locLatitude,locLongitude])
        print(urlString)

        Alamofire.request(urlString).responseJSON { response in
            if let json = response.result.value {
                let responseObject = json as? NSDictionary
//                print(responseObject)
                print("\(responseObject?.value(forKeyPath: "main.temp") ?? "" )")
                print("\(responseObject?.value(forKeyPath: "main.humidity") ?? "" )")
                print(responseObject?.value(forKeyPath: "weather.description" ) as! Array<String>)
                print("\(responseObject?.value(forKeyPath: "wind.speed") ?? "" )")
                print("\(responseObject?.value(forKeyPath: "wind.deg") ?? "" )")
                
                let temperatureStr = "\(responseObject?.value(forKeyPath: "main.temp") ?? "" )"
                let humidityStr = "\(responseObject?.value(forKeyPath: "main.humidity") ?? "" )"
                var rainyArr = responseObject?.value(forKeyPath: "weather.description" ) as! Array<String>
                let speedStr = "\(responseObject?.value(forKeyPath: "wind.speed") ?? "" )"
                let degStr = "\(responseObject?.value(forKeyPath: "wind.deg") ?? "" )"
                
                let cityDet = CityModel(temperature: temperatureStr, humidity: humidityStr, rainChances: rainyArr[0], speed: speedStr, deg: degStr, gust: "")
                
                onSuccess(cityDet)
            }
        }
    }

}
