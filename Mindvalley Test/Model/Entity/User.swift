//
//  User.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/16/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper

class User: BaseEntity {
    var name: String!
    var username: String!
    var links: Dictionary<String, String>!
    var profileImages: Dictionary<String, String>!
    
    required override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        name <- map["name"]
        username <- map["user_name"]
        
        profileImages <- map["profile_image"]
        links <- map["links"]

    }
}
