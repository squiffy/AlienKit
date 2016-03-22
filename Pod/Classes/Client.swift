//
//  Client.swift
//  Pods
//
//  Created by Will Estes on 3/20/16.
//
//

import Foundation
import Alamofire
import SwiftyJSON
import p2_OAuth2

/// Protocol to implement different kinds of clients
public protocol Client {
    
    /// Generic type represnting an `OAuth2` flow.
    associatedtype T: OAuth2
    
    /// tracks a session in a `Client` object.
    var oauthSession :T { get }
 
    func authenticate(success: (Void) -> Void, failure: (ErrorType?) -> Void)
    
    /**
     function to handle authorized API requests
     
     - Parameter method: HTTP request type
     - Parameter URLString: API endpoint to request
     - Parameter parameters: HTTP parameters to send with the request
     - Parameter encoding: method of encoding to encode `parameters`
     - Parameter headers: HTTP headers to send with the request.
     
     - Returns: object representing the request
     */
    func request(
    method: Alamofire.Method,
    _ URLString: URLStringConvertible,
    parameters: [String: AnyObject]?,
    encoding: Alamofire.ParameterEncoding,
    headers: [String: String]?) -> Alamofire.Request
    
    // here comes the actual API stuff
}

extension Client {
    
    public func getPostsFrom(subreddit: String, after: Listing? = nil, success: (Listing) -> Void, failure: (Void) -> Void) {
        
        var params :[String:String]?
        
        if let listing = after {
            if let after = listing.after {
                params = ["after" : after, "count" : String(listing.things.count)]
            }
        }
        self.request(.GET, "https://oauth.reddit.com/r/\(subreddit)", parameters: params).responseJSON(completionHandler: { response in
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                if let kind = json["kind"].string {
                    if kind == "Listing" {
                        if (json["data"].dictionary != nil) {
                            return success(Parser.parseListFromJSON(json["data"]))
                        }
                    }
                }
                
                failure()
            }
        })
    }
    
    // Code below has been adapted from https://github.com/p2/OAuth2
    
    /**
     function to handle authorized API requests
     
     - Parameter method: HTTP request type
     - Parameter URLString: API endpoint to request
     - Parameter parameters: HTTP parameters to send with the request
     - Parameter encoding: method of encoding to encode `parameters`
     - Parameter headers: HTTP headers to send with the request.
     
     - Returns: object representing the request
     */
    public func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          parameters: [String: AnyObject]? = nil,
          encoding: Alamofire.ParameterEncoding = .URL,
          headers: [String: String]? = nil) -> Alamofire.Request
    {
        
        
        var hdrs = headers ?? [:]
        
        // attempt to renew token if expired
        //oauthSession.authorize()
        
        if let token = oauthSession.clientConfig.accessToken {
            hdrs["Authorization"] = "Bearer \(token)"
        }
        return Alamofire.request(
            method,
            URLString,
            parameters: parameters,
            encoding: encoding,
            headers: hdrs)
    }
}
