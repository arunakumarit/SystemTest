//
//  Constants.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit
import SystemConfiguration

class Constants{

    static let kNoInternetTile = "No Network Connection!"
    static let kNoInternetConnection = "You're not connected to the internet. Please check your internet connection and try again later."
    
    static func isNetworkReachable() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }

}
enum CellIdentifiers: String {
    case LocationCellIdentifier
    case FireCastCellIdentifier
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
    case  CityVCID
    case  MetricImperialVCID
    case FiveDaysForeCastVCID
}
