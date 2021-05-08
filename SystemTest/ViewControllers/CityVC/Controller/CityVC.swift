//
//  CityVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class CityVC: BaseViewController {

    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var rainLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var degLbl: UILabel!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    
     let viewModel = CityVM()
     var selectedLocationModel = LocationModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "City"
        if appDelegate?.fromScreen == "Settings" {
        }else {
            self.getCityDetailsApiCall()
        }
        
    }

    func getCityDetailsApiCall() {
        //To Check internet Connectivity
        if Constants.isNetworkReachable() {
            self.showHUD(title: "Fetching City Details...")
            DispatchQueue.main.async(execute: { () -> Void in
                let urlString = String(format: "http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=fae7190d7e6433ec3a45285ffcf55c86", arguments: [self.selectedLocationModel.locationLatitude ?? "",self.selectedLocationModel.locationLonguitude ?? ""])
                
                print(urlString)
                _ = self.viewModel.fetchCityDetails(urlStr: urlString, onSuccess: {(cityMdl) in
                    DispatchQueue.main.async {
                        self.hideHud()
                        
                        //update the fields
                        self.temperatureLbl.text = cityMdl.temperature
                        self.humidityLbl.text = cityMdl.humidity
                        self.rainLbl.text = cityMdl.rainChances
                        self.speedLbl.text = cityMdl.speed
                        self.degLbl.text = cityMdl.deg
                    }
                }, onError: { (error) in
                    self.hideHud()
                    self.showAlert(title: "Fetching City Details failed!", message: "Failed to Fetching City Details. Please try again.")
                })
            })
        } else {
            //IF NO INTERNET AVAILABLE NEED TO DISPLAY ALERT
            self.showAlert(title: Constants.kNoInternetTile, message: Constants.kNoInternetConnection)
        }
    }
    
}
