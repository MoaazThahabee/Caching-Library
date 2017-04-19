//
//  DownloaderFactory.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/18/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class DownloaderFactory: NSObject {
    static let sharedInstance = DownloaderFactory()

    func createDownloader(with url: String, type: FileType, requester: FileDownloaderDelegate) -> BaseFileDownloader {
        
        var downloader: BaseFileDownloader
        switch type {
        case .json:
            downloader = JSONFileDownloader(url: url, requester: requester)
            break
        case .text:
            downloader = TextFileDownloader(url: url, requester: requester)
            break
        case .image:
            downloader = ImageFileDownloader(url: url, requester: requester)
            break
        }
        
        return downloader
    }
}
