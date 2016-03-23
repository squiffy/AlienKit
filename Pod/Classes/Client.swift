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
    /**
     fetch posts from a subreddit
     
     - parameter subreddit: the name or the subreddit to get posts from
     - parameter after:     `Listing` that you want to get posts after.
     - parameter success:   closure called when the request is sucessful
     - parameter failure:   closure called when the request failed.
     */
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
    
    /**
     Gets the comment tree for a `Link` post
     
     - parameter link:    `link` to get comments fo
     - parameter success: closure called when the request is sucessful
     - parameter failure: losure called when the request failed.
     */
    public func getCommentsFor(link: Link, success: (Listing) -> Void, failure: (Void) -> Void) {
        
        let subreddit = link.subreddit!
        let url = "https://oauth.reddit.com/r/\(subreddit)/comments/\(link.id!)"
        
        self.request(.GET, url).responseJSON(completionHandler: { response in
            
            // so this request has an array in the root. index 0 = link listing. index 1 = comment tree.
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                if let json = json.array?[1] {
                    if let kind = json["kind"].string {
                        if kind == "Listing" {
                            if json["data"].dictionary != nil {
                                return success(Parser.parseListFromJSON(json["data"]))
                            }
                        }
                    }
                }
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
