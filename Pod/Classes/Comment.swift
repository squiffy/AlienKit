//
//  Comment.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Comment : Thing {
    
    // everything else
    public let created: Int?
    public let createdUTC: Int?
    public let approvedBy: String?
    public let author: String?
    public let authorFlairCSSClass: String?
    public let authorFlairText: String?
    public let bannedBy: String?
    public let body: String?
    public let body_html: String?
    public let edited: Bool?
    public let editedDate: Int?
    public let gilded: Int?
    public let likes: Bool?
    public let linkAuthor: String?
    public let linkURL: String?
    public let numReports: Int?
    public let parentId: String?
    public let replies: Listing?
    public let saved: Bool?
    public let score: Int?
    public let scoreHidden: Bool?
    public let subreddit: String?
    public let subredditId: String?
    public let distinguished: String?
    
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
        
        self.approvedBy = data["approvedBy"].string
        self.author = data["author"].string
        self.authorFlairCSSClass = data["author_flair_css_class"].string
        self.authorFlairText = data["author_flair_text"].string
        self.bannedBy = data["banned_by"].string
        self.body = data["body"].string
        self.body_html = data["body_html"].string
        
        // editing is a special case due to bad reddit API design :\
        
        // attempt to get it as a date
        if let epoch = data["edited"].float {
            self.edited = true
            self.editedDate = Int(epoch)
        } else {
            self.edited = data["edited"].bool
            self.editedDate = nil
        }
        
        self.gilded = data["gilded"].int!
        self.likes = data["likes"].bool
        self.linkAuthor = data["link_title"].string
        self.linkURL = data["link_url"].string
        self.numReports = data["num_reports"].int
        self.parentId = data["parentId"].string
        
        if data["replies"].dictionary != nil {
            self.replies = Parser.parseListFromJSON(data["replies"])
        } else {
            self.replies = nil
        }
        
        self.saved = data["saved"].bool
        self.score = data["score"].int
        self.scoreHidden = data["score_hidden"].bool
        
        self.subreddit = data["subreddit"].string
        self.subredditId = data["subreddit_id"].string
        self.distinguished = data["distinguished"].string
        
        super.init(id: data["id"].string, name: data["name"].string)
    }
    
}