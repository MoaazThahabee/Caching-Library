//
//  CacheManager.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class CacheManager: NSObject {
    static let sharedInstance = CacheManager()
    
    let memoryCache = NSCache<NSString, AnyObject>()
    
    var maxMemoryCost: UInt = 0 {
        didSet {
            self.memoryCache.totalCostLimit = Int(maxMemoryCost)
        }
    }
    
    public override init() {
        super.init()
        
        let cacheName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String + ".RemoteFileDownloader"
        memoryCache.name = cacheName
        
        memoryCache.evictsObjectsWithDiscardedContent = true
        NotificationCenter.default.addObserver(
                self, selector: #selector(clearMemoryCache), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    open func store(_ object: AnyObject, withCost cost: Int, forKey key: String, completionHandler: (() -> Void)? = nil) {
        memoryCache.setObject(object, forKey: key as NSString, cost: cost)
        
        if let handler = completionHandler {
            DispatchQueue.main.async {
                handler()
            }
        }
    }
    
    open func removeObject(forKey key: String, completionHandler: (() -> Void)? = nil) {
        memoryCache.removeObject(forKey: key as NSString)
        
        if let handler = completionHandler {
            DispatchQueue.main.async {
                handler()
            }
        }
    }

    open func retrieveObject(forKey key: String) -> AnyObject? {
        return memoryCache.object(forKey: key as NSString)
    }
    
    open func isObjectCached(forKey key: String) -> Bool {
        if memoryCache.object(forKey: key as NSString) != nil {
            return true
        }
        
        return false
    }
    
    public func clearMemoryCache() {
        memoryCache.removeAllObjects()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
