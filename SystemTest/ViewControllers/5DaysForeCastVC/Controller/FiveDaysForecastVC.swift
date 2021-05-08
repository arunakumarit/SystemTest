//
//  5DaysForecastVC.swift
//  SystemTest
//
//  Created by tummaa1 on 08/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class FiveDaysForecastVC: BaseViewController {
    
    @IBOutlet weak var foreCastTable: UITableView!
    var selectedLocationModel = LocationModel()
    let viewModel = CityVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCityDetailsApiCallFor5daysForeCast()
        self.setTableview()
    }
    func getCityDetailsApiCallFor5daysForeCast() {
        //To Check internet Connectivity
        if Constants.isNetworkReachable() {
            self.showHUD(title: "Fetching City Details...")
            DispatchQueue.main.async(execute: { () -> Void in
                
                let urlString = String(format: "http://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric", arguments: [self.selectedLocationModel.locationLatitude ?? "",self.selectedLocationModel.locationLonguitude ?? ""])
                print(urlString)
                _ = self.viewModel.fetchCityDetailsFor5DaysForecast(urlStr: urlString, onSuccess: {(cityMdl) in
                    DispatchQueue.main.async {
                        self.hideHud()
                        //update the fields
                        
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

extension FiveDaysForecastVC: UITableViewDelegate, UITableViewDataSource {
    
    func setTableview() {
        self.foreCastTable.delegate = self
        self.foreCastTable.dataSource = self
        self.foreCastTable.estimatedRowHeight = 300
        self.foreCastTable.rowHeight = UITableView.automaticDimension
        self.foreCastTable.tableFooterView = UIView()
        self.foreCastTable.separatorColor = UIColor.black
        self.foreCastTable.layer.borderColor = UIColor.black.cgColor
        self.foreCastTable.layer.borderWidth = 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = CellIdentifiers.FireCastCellIdentifier.rawValue
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FiveDayForecastCell
        if  cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier) as? FiveDayForecastCell
        }
        cell?.selectionStyle = .none
        return cell ?? FiveDayForecastCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
}
