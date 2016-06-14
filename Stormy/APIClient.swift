//
//  APIClient.swift
//  Stormy
//
//  Created by Arshin Jain on 6/9/16.
//  Copyright © 2016 Arshin Jain. All rights reserved.
//

import Foundation

public let TRENetworkingErrorDomain = "com.Arshin.Stormy.NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

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
    
    init(config: NSURLSessionConfiguration, APIKey: String)
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion -> Void) -> JSONTask
    
    // Create and update data from the request object provided by us
    func fetch<T>(request:NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void)
    
    
}


extension APIClient {
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask {
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            guard let HTTPResponse = response as? NSHTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                
                let error = NSError(domain: TRENetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            
            // error checking -- We may receive a 500 response
                
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject]
                        completion(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completion(nil, HTTPResponse, error)
                    }
                // if error code is not 200
                default: print("Received HTTP Response: \(HTTPResponse.statusCode) - not handled")
                    
                } // end else --
            }
        }
        
        return task
    }

    func fetch<T>(request:NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void) {
        
        let task = JSONTaskWithRequest(request) { json, response, error in
            
            guard let json = json else {
                if let error = error {
                    completion(.Failure(error))
                } else { // if both are nil
                    // TODO: Implement Error Handling
                }
            return // completion handler has return type void -- leave scope
            }
            
            if let value = parse(json) {
                completion(.Success(value))
            } else {
                let error = NSError(domain: TRENetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                completion(.Failure(error))
            }
            
        }
        
        task.resume()
        
        
    }


}











