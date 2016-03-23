//
//  OEmbed.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class OEmbed {
    public let providerUrl: String?
    public let description: String?
    public let title: String?
    public let url: String?
    public let authorName: String?
    public let height: Int?
    public let width: Int?
    public let html: String?
    public let thumbnail_width: Int?
    public let version: String?
    public let providerName: String?
    public let thumbnailURL: String?
    public let type: String?
    public let thumbnailHeight: Int?
    public let authorURL: String?
    
    /**
     initialize an `OEmbed` object
     
     - parameter data: JSON data from the API endpoint
     
     - returns: a `OEmbed` object.
     */
    init(data: JSON) {
        self.providerUrl = data["provider_url"].string
        self.description = data["description"].string
        self.title = data["title"].string
        self.url = data["url"].string
        self.authorName = data["author_name"].string
        self.height = data["height"].int
        self.width = data["width"].int
        self.html = data["html"].string
        self.thumbnail_width = data["thumbnail_width"].int
        self.version = data["version"].string
        self.providerName = data["provider_name"].string
        self.thumbnailURL = data["thumbnail_url"].string
        self.type = data["type"].string
        self.thumbnailHeight = data["thumbnail_height"].int
        self.authorURL = data["author_url"].string
    }
    
    
}
