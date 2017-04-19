//
//  Category.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/17/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper
class Category: BaseEntity {
    var links: Dictionary<String, String>!
    var title: String!
    var photoCounts: Int!

    required override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
        
        title <- map["title"]
        photoCounts <- map["photo_count"]
        links <- map["links"]
    }
}
