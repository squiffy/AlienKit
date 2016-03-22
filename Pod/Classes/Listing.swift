//
//  Listing.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation

public class Listing {
    
    public let before: String?
    public let after: String?
    public let modhash: String?
    public var things: [Thing]
    
    init(before: String?, after: String?, modhash: String?) {
        self.before = before
        self.after = after
        self.modhash = modhash
        self.things = [Thing]()
    }
    
}
