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

public class Thing {
    
    public var id: String?
    public var name: String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
    
}