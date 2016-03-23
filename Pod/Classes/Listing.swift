//
//  Listing.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation

public class Listing {
    
    /// The fullname of the listing that follows before this page. `null` if there is no previous page.
    public let before: String?
    
    /// The fullname of the listing that follows after this page. `null` if there is no next page.
    public let after: String?
    
    ///
    public let modhash: String?
    
    /// A list of `thing`s that this Listing wraps.
    public var things: [Thing]
    
    /**
     initializer for a `Listing` object.
     
     - parameter before:  The fullname of the listing that follows before this page. `null` if there is no previous page.
     - parameter after:   The fullname of the listing that follows after this page. `null` if there is no next page.
     - parameter modhash: modhash in the data
     
     - returns: a new `Listing` object.
     */
    init(before: String?, after: String?, modhash: String?) {
        self.before = before
        self.after = after
        self.modhash = modhash
        self.things = [Thing]()
    }
    
}
