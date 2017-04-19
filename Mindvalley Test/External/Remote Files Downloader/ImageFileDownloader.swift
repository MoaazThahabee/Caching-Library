//
//  ImageDownloader.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class ImageFileDownloader: BaseFileDownloader {
    override func handle(downloadedData data: Data) {
        let image = UIImage(data: data)!
        
        cacheManager.store(image, withCost:Int(image.size.width * image.size.height), forKey:self.url!.absoluteString)
        for object in self.requesters {
            object.fileDownloaderDidFinishedDownloading(downloader: self, object: image)
        }
    }
}
