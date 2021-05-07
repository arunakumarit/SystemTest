//
//  SettingsVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingsTable: UITableView!
    var settingsArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        self.setTableview()
        settingsArr = ["Help", "5-Day's ForeCast","Home"]
    }
    
}
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func setTableview() {
        self.settingsTable.delegate = self
        self.settingsTable.dataSource = self
        self.settingsTable.estimatedRowHeight = 300
        self.settingsTable.rowHeight = UITableView.automaticDimension
        self.settingsTable.tableFooterView = UIView()
        self.settingsTable.separatorColor = UIColor.black
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = CellIdentifiers.LocationCellIdentifier.rawValue
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? LocationCell
        if  cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier) as? LocationCell
        }
        cell?.selectionStyle = .none
        cell?.locationName.text = settingsArr[indexPath.row]
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
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let frontNavigationController: UINavigationController
            let rearNavigationController: UINavigationController
            let revealController = SWRevealViewController()
            var mainRevealController = SWRevealViewController()
            
            var frontViewController: UIViewController!
            let rearViewController: UIViewController!
            
            switch indexPath.row {
            case 0:
                let storyBoard = UIStoryboard(name: StoryBoardName.kMainSB.rawValue, bundle: nil)
                frontViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.HelpVCID.rawValue)as? HelpVC
                rearViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.SettingsVCID.rawValue)as? SettingsVC
                frontNavigationController =  UINavigationController(rootViewController: frontViewController)
                rearNavigationController = UINavigationController(rootViewController: rearViewController)
                revealController.frontViewController = frontNavigationController
                revealController.rearViewController = rearNavigationController
                revealController.rearViewRevealWidth = frontViewController.view.frame.width-70
                mainRevealController  = revealController
                appDelegate!.window?.rootViewController = mainRevealController
                break
            case 1:
                let storyBoard = UIStoryboard(name: StoryBoardName.kMainSB.rawValue, bundle: nil)
                frontViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.CityVCID.rawValue)as? CityVC
                rearViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.SettingsVCID.rawValue)as? SettingsVC
                frontNavigationController =  UINavigationController(rootViewController: frontViewController)
                rearNavigationController = UINavigationController(rootViewController: rearViewController)
                revealController.frontViewController = frontNavigationController
                revealController.rearViewController = rearNavigationController
                revealController.rearViewRevealWidth = frontViewController.view.frame.width-70
                mainRevealController  = revealController
                appDelegate!.window?.rootViewController = mainRevealController
                break
            case 2:
                let storyBoard = UIStoryboard(name: StoryBoardName.kMainSB.rawValue, bundle: nil)
                frontViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.HomeVCID.rawValue)as? ViewController
                rearViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.SettingsVCID.rawValue)as? SettingsVC
                frontNavigationController =  UINavigationController(rootViewController: frontViewController)
                rearNavigationController = UINavigationController(rootViewController: rearViewController)
                revealController.frontViewController = frontNavigationController
                revealController.rearViewController = rearNavigationController
                revealController.rearViewRevealWidth = frontViewController.view.frame.width-70
                mainRevealController  = revealController
                appDelegate!.window?.rootViewController = mainRevealController
                break
            default:
                break
            }
        }
}
