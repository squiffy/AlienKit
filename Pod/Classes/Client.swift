//
//  Client.swift
//  AlienKit
//
//  Created by Will Estes on 3/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/// client class
public final class Client {
    
    private var token :Token?
    private let uuid :NSUUID
    
    /**
     initializer for a "userless" session.
     
     - Parameter secret: app id from your app preferences page on [reddit](https://www.reddit.com/prefs/apps/)
     - Parameter completion: closure called when the authentication process is done.
     - Returns: a new optional client object
     */
    public init?(id: String, completion: (Client?, NSError?) -> Void) {
        
        // oauth time.
        
        
        // use basic auth with username the secret and passwor blank
        // a ':' will need to be appended for basic auth to work correct
        
        if let encodedSecret = "\(id):".dataUsingEncoding(NSUTF8StringEncoding) {
            // generate UUID
            self.uuid = NSUUID()
            
            let base64creds = NSString(data:encodedSecret.base64EncodedDataWithOptions([]), encoding:  NSUTF8StringEncoding)!
            let headers = ["Authorization" : "Basic \(base64creds)"]
            let params = ["grant_type" : "https://oauth.reddit.com/grants/installed_client", "device_id" : self.uuid.UUIDString]
            
            // send off the request
            Alamofire.request(.POST, "https://www.reddit.com/api/v1/access_token", parameters: params, encoding: .URL, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            let tokenResponse = JSON(value)
                            self.token = Token(accessToken: tokenResponse["access_token"].stringValue, tokenType: tokenResponse["token_type"].stringValue, scope: tokenResponse["scope"].stringValue, expiry: NSTimeInterval(tokenResponse["expires_in"].intValue))
                            
                            completion(self, nil)
                        }
                    case .Failure(let error):
                        completion(nil, error)
                    }
            }
            
            // temporarily set accessToken to nil since request is async
            self.token = nil
            return
        }
        
        // could not encode secret
        return nil
        
        
    }
    
    /**
     initializer for a authenticated session
     
     - Parameter username: reddit username
     - Parameter password: reddit password
     - Returns: a new client object
     */
    public init?(username: String, password: String) {
        
        self.token = nil
        self.uuid = NSUUID()
        
    }
    
}