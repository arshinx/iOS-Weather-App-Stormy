//
//  APIClient.swift
//  Stormy
//
//  Created by Arshin Jain on 6/9/16.
//  Copyright © 2016 Arshin Jain. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]
typealias JSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias JSONTask = NSURLSessionDataTask

enum APIResult {
    case success
    case failure
}

protocol APIClient {
    
    var configuration: NSURLSessionConfiguration { get }
    var session: NSURLSession { get }
    
    init(config: NSURLSessionConfiguration)
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion -> Void) -> JSONTask
    
    // Create and update data from the request object provided by us
    
    
}