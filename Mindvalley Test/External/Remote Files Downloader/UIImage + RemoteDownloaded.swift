//
//  UIImage + RemoteDownloaded.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/19/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageFromDownloader(with url: String) {
        self.id = RemoteFileDownloader.sharedInstance.downloadFile(with: url, type: .image, requester: self)
    }
}
extension UIImageView: FileDownloaderDelegate {
    var id: String {
        get {
            return "\(self.tag)"
        }
        set {
            self.tag = Int(newValue)!
        }
    }

    func fileDownloaderDidFailedDownloading(downloader: BaseFileDownloader) {
        
    }

    func fileDownloaderDidCanceledDownloading(downloader: BaseFileDownloader) {

    }

    func fileDownloaderDidFinishedDownloading(downloader: BaseFileDownloader, object: AnyObject) {
        self.image = object as? UIImage
    }

    func fileDownloader(didLoadCached object: AnyObject) {
        self.image = object as? UIImage
    }
    
    func identifier() -> String {
        return "1"
    }
}
