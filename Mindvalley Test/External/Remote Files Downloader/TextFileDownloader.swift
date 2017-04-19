//
//  TextFileDownloader.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class TextFileDownloader: BaseFileDownloader {
    override func handle(downloadedData data: Data) {
        let text = NSString(data: data, encoding:String.Encoding.utf8.rawValue) as AnyObject
        
        cacheManager.store(text , withCost:data.count, forKey:self.url!.absoluteString)
        for object in self.requesters {
            object.fileDownloaderDidFinishedDownloading(downloader: self, object: text)
        }
    }
}
