//
//  Parser.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

class Parser {
    
    // we got data representing a list object. parse it
    class func parseListFromJSON(json: JSON) -> Listing {
        let list = Listing(before: json["before"].string, after: json["after"].string, modhash: json["modhash"].string)
        
        if let children = json["children"].array {
            for child in children {
                
                let type = ThingType(rawValue: child["kind"].string!)
                
                if let type = type {
                    var thing :Thing?
                    
                    switch type {
                    case .Comment:
                       thing = Comment(data: child["data"])
                    case .Account:
                        thing = Account(data: child["data"])
                    case .Link:
                        thing = Link(data: child["data"])
                    case .Message:
                        //thing = Message(data: child["data"])
                        break;
                    case .Subreddit:
                        //thing = Subreddit(data: child["data"])
                        break;
                    case .Award:
                        break;
                    case .PromoCampaign:
                        break;
                    }
                    
                    if let thing = thing {
                        list.things.append(thing)
                    }

                    
                }
            }
        }
        
        return list
    }
    
}
