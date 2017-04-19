//
//  BaseDownloader.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

protocol FileDownloaderDelegate {
    var id: String {get set}
    func fileDownloader(didLoadCached object: AnyObject)
    func fileDownloaderDidFinishedDownloading(downloader: BaseFileDownloader, object: AnyObject)
    func fileDownloaderDidCanceledDownloading(downloader: BaseFileDownloader)
    func fileDownloaderDidFailedDownloading(downloader: BaseFileDownloader)
}

class BaseFileDownloader {
    public var cacheManager: CacheManager {
        get {
            return CacheManager.sharedInstance
        }
    }
    
    var downloadTask: URLSessionDataTask!
    var requesters = [FileDownloaderDelegate]()
    
    public var url: URL? {
        return downloadTask.originalRequest?.url
    }
    
    func cancelDownloading(requester: FileDownloaderDelegate) {
        if let _ = self.downloadTask.originalRequest?.url {
            self.removeRequester(requester: requester)
            if self.requesters.count == 0 {
                self.downloadTask.cancel()
                
                for object in self.requesters {
                    object.fileDownloaderDidCanceledDownloading(downloader: self)
                }
            }
        }
    }
    
    func addDownloadRequest(requester: FileDownloaderDelegate) -> String{
        self.requesters.append(requester)
        return "\(self.requesters.count)"
    }
    
    func startDownloading() {
        self.downloadTask.resume()
    }
    
    private func removeRequester(requester: FileDownloaderDelegate) {
        let indetifier = requester.id
        for i in 0..<self.requesters.count {
            if self.requesters[i].id == indetifier {
                self.requesters.remove(at: i)
                return
            }
        }
    }
    
    init(url: String, requester: FileDownloaderDelegate) {
        self.requesters.append(requester)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:URL(string: url)!)
        downloadTask = session.dataTask(with: request) { (data, response, error)  in
            if let actualData = data, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    self.handle(downloadedData: actualData)
                }
            }
            else {
                for object in self.requesters {
                    object.fileDownloaderDidFailedDownloading(downloader: self)
                }
            }
            
            self.requesters.removeAll()
        }
    }
    
    func handle(downloadedData data: Data) {
        
    }
}
