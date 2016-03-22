//
//  Media.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Media {
    
    public let type: String?
    public let oembed: OEmbed?
    
    init(data: JSON) {
        self.type = data["type"].string
        self.oembed = OEmbed(data: data["oembed"])
    }
}
