//
//  ForecastClient.swift
//  Stormy
//
//  Created by Arshin Jain on 6/14/16.
//  Copyright © 2016 Arshin Jain. All rights reserved.
//

import Foundation

final class ForecastAPIClient: APIClient {
   
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
}