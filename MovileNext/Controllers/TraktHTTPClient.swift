//
//  TraktHTTPClient.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import Alamofire
import UIKit

class TraktHTTPClient {
    
    private lazy var manager: Alamofire.Manager = {
        
        let configuration: NSURLSessionConfiguration = {
           
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["content-type"] = "application/json"
            headers["trakt-api-key"] = "4f5d3c5abda93cf0bc2697e8fe8cbc23257112a5f8130b47fa8c651c3d51beed"
            headers["trakt-api-version"] = "2"
            
            configuration.HTTPAdditionalHeaders = headers
            
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
   
}
