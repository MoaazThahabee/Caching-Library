//
//  CommunicationManager.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/16/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON
class CommunicationManager: BaseManager {
    static let sharedInstance = CommunicationManager()
    let getDataURL = "https://pastebin.com/raw/wgkJgazE"
    
    func pictures(onComplete: ((_ pcitures:[Picture]?, _ message:String?) -> Void)?) {
        Alamofire.request(getDataURL, method: .get, parameters: nil, headers: nil).responseArray { (response: DataResponse<[Picture]>) in
            var picturesArray: [Picture]?
            var errorMessage: String?
            if let actualResult = response.result.value {
                picturesArray = actualResult
            }
            else {
                errorMessage = response.error!.localizedDescription
            }
            
            if let actualOnComplete = onComplete {
                actualOnComplete(picturesArray, errorMessage)
            }
        }
    }
}
