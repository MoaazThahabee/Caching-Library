//
//  RemoteFileDownloader.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit


class RemoteFileDownloader: NSObject {
    static let sharedInstance = RemoteFileDownloader()
    
    private var downloaders = Dictionary<String, BaseFileDownloader>()
    /// Cache used by this manager
    public var cacheManager: CacheManager {
        get {
            return CacheManager.sharedInstance
        }
    }
    
    public var downloaderFactory: DownloaderFactory {
        get {
            return DownloaderFactory.sharedInstance
        }
    }
    
    public func downloadFile(with url:String, type: FileType, requester: FileDownloaderDelegate) -> String {
        var idetifier = "1"
        if let cachedObject = cacheManager.retrieveObject(forKey: url) {
            requester.fileDownloader(didLoadCached: cachedObject)
        }
        else if let downloader = self.downloaders[url] {
            idetifier = downloader.addDownloadRequest(requester: requester)
        }
        else {
            let downloader = self.downloaderFactory.createDownloader(with: url, type: type, requester: requester)
            self.downloaders[url] = downloader
            downloader.startDownloading()
        }
        
        return idetifier
    }
}




