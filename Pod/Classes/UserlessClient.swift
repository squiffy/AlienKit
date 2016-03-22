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
import p2_OAuth2

/// client class for userless authorization
public final class UserlessClient : Client {
    
    public typealias T = OAuth2ClientCredentialsReddit
    
    public var oauthSession :OAuth2ClientCredentialsReddit
    
    /**
        authenticates with reddit's oauth.
         - Parameter success: closure called when authorized with reddit
         - Parameter failure: closure called when authorization with reddit failed
    */
    public func authenticate(success: (Void) -> Void, failure: (ErrorType?) -> Void) {
    
        oauthSession.onAuthorize = { parameters in
            success()
        }
        oauthSession.onFailure = { error in
            if let error = error {
                failure(error)
            } else {
                failure(nil)
            }
        }
        oauthSession.authorize()
    
    }
    
    /**
     initializer for a "userless" session.
     
     - Parameter secret: app id from your app preferences page on [reddit](https://www.reddit.com/prefs/apps/)
     - Returns: a new optional client object
     */
    public init(id: String) {
        
       let settings = [
            "client_id": id,
            "client_secret": "",
            "authorize_uri": "https://www.reddit.com/api/v1/authorize",
            "token_uri": "https://www.reddit.com/api/v1/access_token",
            "scope": "",
            "redirect_uris": [""],
            "keychain": false,
            "title": "Reddit",
            "device_id": "DO_NOT_TRACK_THIS_DEVICE"
            ] as OAuth2JSON
        
        oauthSession = OAuth2ClientCredentialsReddit(settings: settings)
        
    }
}