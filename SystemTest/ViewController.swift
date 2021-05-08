//
//  ViewController.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    var locationsArr = [LocationModel]()
    var selectedLoc = LocationModel()
    var filteredData = [LocationModel]()
    var totalLocArr = [LocationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Home"
        searchBar.returnKeyType = .search
        if self.revealViewController() != nil {
            let revealButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            navigationItem.leftBarButtonItem = revealButtonItem
            navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        self.setTableview()
        //initially I have taken some static locations
        locationsArr.removeAll()
        var locationMdl = LocationModel()
        locationMdl.locationName = "Hyderabad"
        locationMdl.locationLatitude = "17.3850"
        locationMdl.locationLonguitude = "78.4867"
        locationsArr.append(locationMdl)
        
        locationMdl.locationName = "Banglore"
        locationMdl.locationLatitude = "12.9716"
        locationMdl.locationLonguitude = "77.5946"
        locationsArr.append(locationMdl)
        
        locationMdl.locationName = "Mumbai"
        locationMdl.locationLatitude = "19.0760"
        locationMdl.locationLonguitude = "72.8777"
        locationsArr.append(locationMdl)
        
        locationMdl.locationName = "Pune"
        locationMdl.locationLatitude = "18.5204"
        locationMdl.locationLonguitude = "73.8567"
        locationsArr.append(locationMdl)
        
        locationMdl.locationName = "Kerala"
        locationMdl.locationLatitude = "10.8505"
        locationMdl.locationLonguitude = "76.2711"
        locationsArr.append(locationMdl)
        
        totalLocArr = locationsArr
    }

    @IBAction func mapButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueID.mapViewSegue.rawValue, sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.citySegue.rawValue {
            let destinationVC = segue.destination as? CityVC
            destinationVC?.selectedLocationModel = selectedLoc
        }
    }
    func searchBasedOnInputStr(inputStr: String) {
        filteredData = locationsArr.filter { $0.locationName?.localizedCaseInsensitiveContains(inputStr) ?? true }
        self.locationsArr.removeAll()
        self.locationsArr = filteredData
        locationsTable.reloadData()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableview() {
        self.locationsTable.delegate = self
        self.locationsTable.dataSource = self
        self.locationsTable.estimatedRowHeight = 300
        self.locationsTable.rowHeight = UITableView.automaticDimension
        self.locationsTable.tableFooterView = UIView()
        self.locationsTable.separatorColor = UIColor.black
        self.locationsTable.layer.borderColor = UIColor.black.cgColor
        self.locationsTable.layer.borderWidth = 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = CellIdentifiers.LocationCellIdentifier.rawValue
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? LocationCell
        if  cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier) as? LocationCell
        }
        cell?.selectionStyle = .none
        let locationModel = locationsArr[indexPath.row]
        cell?.locationName.text = locationModel.locationName
        return cell ?? LocationCell()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedLoc = locationsArr[indexPath.row]
        if appDelegate?.fromScreen == "Settings" {
            appDelegate?.fromScreen = "Settings"
            let storyBoard : UIStoryboard = UIStoryboard(name:StoryBoardName.kMainSB.rawValue, bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.FiveDaysForeCastVCID.rawValue) as! FiveDaysForecastVC
            nextViewController.selectedLocationModel = selectedLoc

            self.navigationController?.pushViewController(nextViewController, animated: true)
        }else {
            appDelegate?.fromScreen = "city"
            self.performSegue(withIdentifier: SegueID.citySegue.rawValue, sender: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, indexTag in
            self.locationsArr.remove(at: indexPath.row)
            tableView.reloadData()
        }
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let char = searchText.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                self.locationsArr.removeAll()
                self.locationsArr = totalLocArr
                self.locationsTable.reloadData()
            }else {
                self.searchBasedOnInputStr(inputStr: searchText)
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

