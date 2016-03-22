//
//  Link.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Link : Thing {
    
    public let created: Int?
    public let createdUTC: Int?
    
    public let author: String?
    public let authorFlairCSSClass: String?
    public let authorFlairText: String?
    public let clicked: Bool?
    public let domain: String?
    public let hidden: Bool?
    public let isSelf: Bool?
    public let likes: Bool?
    public let ups: Int?
    public let downs: Int?
    public let linkFlairCSSClass: String?
    public let linkFlairText: String?
    public let locked: Bool?
    public let media: Media?
    public let previewImages: [PreviewImage]?
    public let numComments: Int?
    public let over18: Bool?
    public let permalink: String?
    public let saved: Bool?
    public let score: Int?
    public let selfText: String?
    public let selfTextHTML: String?
    public let subreddit: String?
    public let subredditId: String?
    public let thumbnail: String?
    public let title: String?
    public let url: String?
    public let edited: Int?
    public let distinguished: String?
    public let stickied: Bool?
    
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
        
        self.author = data["author"].string
        self.authorFlairCSSClass = data["author_flair_css_class"].string
        self.authorFlairText = data["author_flair_text"].string
        self.clicked = data["clicked"].bool
        self.domain = data["domain"].string
        self.hidden = data["hidden"].bool
        self.isSelf = data["is_self"].bool
        self.likes = data["likes"].bool
        self.ups = data["ups"].int
        self.downs = data["downs"].int
        self.linkFlairCSSClass = data["link_flair_css_class"].string
        self.linkFlairText = data["link_flair_text"].string
        self.locked = data["locked"].bool
        self.media = Media(data: data["media"])
        self.numComments = data["num_comments"].int
        self.over18 = data["over_18"].bool
        self.permalink = data["permalink"].string
        self.saved = data["saved"].bool
        self.score = data["score"].int
        self.selfText = data["selftext"].string
        self.selfTextHTML = data["selftext_html"].string
        self.subreddit = data["subreddit"].string
        self.subredditId = data["subreddit_id"].string
        self.thumbnail = data["thumbnail"].string
        self.title = data["title"].string
        self.url = data["url"].string
        self.edited = data["edited"].int
        self.distinguished = data["distinguished"].string
        self.stickied = data["stickied"].bool
        
        if let images = data["preview"]["images"].array {
            var tempPreviews = [PreviewImage]()
            
            for image in images {
                tempPreviews.append(PreviewImage(data: image))
            }
            
            self.previewImages = tempPreviews
            
        } else {
            self.previewImages = nil
        }
        
        
        super.init(id: data["id"].string, name: data["name"].string)
    }
}