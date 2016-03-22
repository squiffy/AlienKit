//
//  Account.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Account : Thing {
    public let created: Int?
    public let createdUTC: Int?
    
    public let commentKarma: Int?
    public let hasMail: Bool?
    public let hasModMail: Bool?
    public let hasVerifiedEmail: Bool?
    public let inboxCount: Int?
    public let isFriend: Bool?
    public let isGold: Bool?
    public let isMod: Bool?
    public let modhash: String?
    public let over18: Bool?
    
    init(data: JSON) {
        if let created = data["created"].float {
            self.created = Int(created)
        } else {
            created = nil
        }
        
        if let createdUTC = data["created_utc"].float {
            self.createdUTC = Int(createdUTC)
        } else {
            createdUTC = nil
        }
        
        self.commentKarma = data["comment_karma"].int
        self.hasMail = data["has_mail"].bool
        self.hasModMail = data["has_mod_mail"].bool
        self.hasVerifiedEmail = data["has_verified_email"].bool
        self.inboxCount = data["inbox_count"].int
        self.isFriend = data["is_friend"].bool
        self.isGold = data["is_gold"].bool
        self.isMod = data["is_mod"].bool
        self.modhash = data["modhash"].string
        self.over18 = data["over_18"].bool
        
        super.init(id: data["id"].string, name: data["name"].string)
    }
}