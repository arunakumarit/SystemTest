//
//  CityVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//


import Foundation

class CHRestError {
    let statusCode: Int
    let statusMessage: String
    init(_ code: Int, _ msg: String) {
        self.statusCode = code
        self.statusMessage = msg
    }
}

