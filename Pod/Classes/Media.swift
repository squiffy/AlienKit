//
//  Media.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

/// class representing a Reddit `Media` object
public class Media {
    
    /// string representing the source of the media
    public let type: String?
    public let oembed: OEmbed?
    
    /**
     initialize a `Media` object
     
     - parameter data: JSON data from the API endpoint
     
     - returns: a `Media` object.
     */
    init(data: JSON) {
        self.type = data["type"].string
        self.oembed = OEmbed(data: data["oembed"])
    }
}
