//
//  APIClient.swift
//  Stormy
//
//  Created by Arshin Jain on 6/9/16.
//  Copyright © 2016 Arshin Jain. All rights reserved.
//

import Foundation

public let TRENetworkingErrorDomain = "com.Arshin.Stormy.NetworkingError"

typealias JSON = [String: AnyObject]
typealias JSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias JSONTask = NSURLSessionDataTask

enum APIResult<T> {
    case Success(T)
    case Failure(ErrorType) // Use Swift's error class and Obj-C's error object
}

protocol APIClient {
    
    var configuration: NSURLSessionConfiguration { get }
    var session: NSURLSession { get }
    
    init(config: NSURLSessionConfiguration)
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion -> Void) -> JSONTask
    
    // Create and update data from the request object provided by us
    func fetch<T>(request:NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void)
    
    
}


extension APIClient {
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion -> Void) -> JSONTask {
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            guard let HTTPResponse = response as? NSHTTPURLResponse else {
                
            }
        }
        
        return task
        
    }
    
}