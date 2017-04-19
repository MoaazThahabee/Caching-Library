//
//  Picture.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/17/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper
class Picture: BaseEntity {
    var owner: User!
    
    var likes: Int!
    var width: Int!
    var height: Int!
    var likedByUser: Bool!
    
    var links: Dictionary<String, String>!
    var urls: Dictionary<String, String>!

    var categories: [Category]!
    required override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        height <- map["height"]
        width <- map["width"]
        likes <- map["likes"]
        likedByUser <- map["liked_by_user"]
        owner <- map["user"]
        
        likedByUser <- map["liked_by_user"]

        
        urls <- map["urls"]
        links <- map["links"]
        categories <- map["categories"]
    }
}
