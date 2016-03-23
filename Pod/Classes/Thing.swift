//
//  Thing.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation

enum ThingType: String {
    case Comment = "t1"
    case Account = "t2"
    case Link = "t3"
    case Message = "t4"
    case Subreddit = "t5"
    case Award = "t6"
    case PromoCampaign = "t7"
}

/// `Thing` object defined by Reddit.
public class Thing {
    
    /// this item's identifier, e.g. "8xwlg"
    public var id: String?
    
    /// Fullname of comment, e.g. "t1_c3v7f8u"
    public var name: String?
    
    /**
     initialize a base thing object
     
     - parameter id:   id of the thing
     - parameter name: name of the thing
     
     - returns: <#return value description#>
     */
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
    
}