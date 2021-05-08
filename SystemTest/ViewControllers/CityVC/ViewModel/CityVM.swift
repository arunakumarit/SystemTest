//
//  CityVM.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import Foundation

typealias APIErrorHandler = (CHRestError) -> Void

class CityVM {
    
    init() {
    }
    
    func fetchCityDetails(urlStr: String, onSuccess: @escaping (CityModel) -> Void,
                           onError: @escaping APIErrorHandler) {
        
        NetworkManagerVC.fetchCityDetailsByLocation(url: urlStr, onSuccess: { (dataSource) in
            onSuccess(dataSource)
        }) { (error) in
            
            onError(error)
            print("CityDetails failed.): \(String(describing: error))")
            
        }
    }
    func fetchCityDetailsFor5DaysForecast(urlStr: String, onSuccess: @escaping (CityModel) -> Void,
                          onError: @escaping APIErrorHandler) {
        
        NetworkManagerVC.fetchCityDetailsByLocationFor5DaysForecast(url: urlStr, onSuccess: { (dataSource) in
            onSuccess(dataSource)
        }) { (error) in
            
            onError(error)
            print("CityDetails failed.): \(String(describing: error))")
            
        }
    }
}
