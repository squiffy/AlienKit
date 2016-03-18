//
//  Token.swift
//  AlienKit
//
//  Created by Will Estes on 3/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

public final class Token {
    let accessToken :String
    let tokenType :String
    let scope :String
    let expiryTime :NSTimeInterval
    let creationEpoch :NSTimeInterval
    
    /**
        initializer for a token object
        - Parameter accessToken: access token
        - Parameter tokenType: type of token
        - Parameter scope: scope of token
        - Parameter expiry: time in seconds the token will expire
        
        - Returns: a OAuth Token
    */
    public init(accessToken: String, tokenType: String, scope: String, expiry: NSTimeInterval) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.scope = scope
        
        self.expiryTime = expiry
        self.creationEpoch = NSDate().timeIntervalSince1970
    }
    
    /**
        sees if the token has expired
        - Returns: True or false denoting whether the token has expired or not.
    */
    public func expired() -> Bool {
        let currentTime = NSDate().timeIntervalSince1970
        
        if (currentTime - self.creationEpoch) <= expiryTime {
            return false
        }
        
        return true
    }
}