//
//  BaseEntity.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/16/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseEntity: NSObject , Mappable {
    var id: String!
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let boolTransform = TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in
        // transform value from String? to Int?
        if let value = value {
            if value == "1" {
                return true
            }
        }
        return false
        }, toJSON: { (value: Bool?) -> String? in
            // transform value from Int? to String?
            if let value = value {
                if value {
                    return "1"
                }
            }
            return "0"
    })
    
    let floatTransform = TransformOf<Float, String>(fromJSON: { (value: String?) -> Float? in
        if let value = value {
            return Float(value)
        }
        return 0
        }, toJSON: { (value: Float?) -> String? in
            // transform value from Int? to String?
            if let value = value {
                return "\(value)"
            }
            
            return nil
    })
    
    let doubleTransform = TransformOf<Double, String>(fromJSON: { (value: String?) -> Double? in
        if let value = value {
            return Double(value)
        }
        return 0
    }, toJSON: { (value: Double?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return "\(value)"
        }
        
        return nil
    })
    
    let intTransform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        if let value = value {
            return Int(value)
        }
        return 0
        }, toJSON: { (value: Int?) -> String? in
            // transform value from Int? to String?
            if let value = value {
                return "\(value)"
            }
            
            return nil
    })
    
    let stringComponentsTransform = TransformOf<[String], String>(fromJSON: { (value: String?) -> [String] in
        if let value = value {
            return value.components(separatedBy: ",")
        }
        return [String]()
    }, toJSON: { (value: [String]?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return value.joined(separator: ",")
        }
        
        return ""
    })
    
    required init?(map: Map) {
        
    }
    
    override init () {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? BaseEntity {
            return id == object.id
        }
        else {
            return false
        }
    }
}
