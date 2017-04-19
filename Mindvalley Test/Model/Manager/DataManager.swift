//
//  DataManager.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/16/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import MapKit
import ObjectMapper

class DataManager: BaseManager, CLLocationManagerDelegate {
    static let sharedInstance = DataManager()
    var pictures: [Picture] = []

    override init() {

    }
        
    deinit {
        // perform the deinitialization
    }
}
