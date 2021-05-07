//
//  Constants.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit
import Alamofire

class Constants{

    static let kNoInternetTile = "No Network Connection!"
    static let kNoInternetConnection = "You're not connected to the internet. Please check your internet connection and try again later."
    static func isNetworkReachable() -> Bool {
        return Alamofire.NetworkReachabilityManager(host: "www.apple.com")?.isReachable ?? false
    }

}
enum CellIdentifiers: String {
    case LocationCellIdentifier
}
enum SegueID: String {
    case mapViewSegue
    case citySegue
}
enum StoryBoardName: String {
    case kMainSB = "Main"
}
enum StoryBoardID: String {
    case  HomeVCID
    case  SettingsVCID
    case  HelpVCID
    case CityVCID
}
