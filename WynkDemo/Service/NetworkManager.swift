//
//  Service.swift
//  WynkDemo
//
//  Created by Smriti on 15/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    public init() { }
    
    func sendUser(_ request: [String:String], completionBlock: @escaping (ResultantDataModel?, NetworkManager.Error?) -> Void) {
           var items = [URLQueryItem]()
         var myURL = URLComponents(string: Constants.full_URL)
    
        for (key,value) in request {
            items.append(URLQueryItem(name: key, value: value))
        }
        myURL?.queryItems = items
        
        var urlRequest = URLRequest(url: (myURL?.url)!)
          urlRequest.httpMethod = "GET"
             print("full request:---\(urlRequest)")
             let task = defaultSession.dataTask(with: urlRequest) { data, urlResponse, error in
                 if let error = error {
                     completionBlock(nil, .http(error.localizedDescription))
                     return
                 }
                 guard let httpResponse = urlResponse as? HTTPURLResponse else {
                     return
                 }
                 if httpResponse.statusCode == 200 {
                     guard let data = data else {
                         return
                     }
                     do {
                         let userResponse = try JSONDecoder().decode(ResultantDataModel.self, from: data)
                         completionBlock(userResponse, nil)
                     } catch let error {
                         completionBlock(nil, .serialization(error.localizedDescription))
                     }
                 } else {
                     completionBlock(nil, .http("Status failed!"))
                 }
             }
             task.resume()

    }
 
}

extension NetworkManager {
    
    enum Error: Swift.Error, Equatable {
        case brokenURL
        case serialization(String)
        case http(String)
    }
    
}


