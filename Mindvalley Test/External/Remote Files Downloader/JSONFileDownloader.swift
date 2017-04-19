//
//  JSONFileDownloader.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class JSONFileDownloader: BaseFileDownloader {
    override func handle(downloadedData data: Data) {
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] as AnyObject
            
            cacheManager.store(json , withCost:data.count, forKey:self.url!.absoluteString)
            for object in self.requesters {
                object.fileDownloaderDidFinishedDownloading(downloader: self, object: json)
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
}
