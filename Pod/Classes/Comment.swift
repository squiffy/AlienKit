//
//  Comment.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Comment: Thing {
    
    /// the time of creation in local epoch-second format.
    public let created: Int?
    
    /// the time of creation in UTC epoch-second format.
    public let createdUTC: Int?
    
    /// who approved this comment. `null` if nobody or you are not a mod
    public let approvedBy: String?
    
    /// the account name of the poster
    public let author: String?
    
    /// the CSS class of the author's flair. subreddit specific
    public let authorFlairCSSClass: String?
    
    /// the text of the author's flair. subreddit specific
    public let authorFlairText: String?
    
    /// who removed this comment. `null` if nobody or you are not a mod
    public let bannedBy: String?
    
    /**
       the raw text. this is the unformatted text which includes the raw markup
       characters such as `**` for bold. `<`, `>`, and `&` are escaped.
    */
    public let body: String?
    
    /**
        the formatted HTML text as displayed on reddit. For example, text that is
        emphasised by `*` will now have `<em>` tags wrapping it. Additionally,
        bullets and numbered lists will now be in HTML list format. **NOTE**: The
        HTMLstring will be escaped. You must unescape to get the raw HTML.
    */
    public let body_html: String?
    
    /// `true` if the comment has been edited; `false` otherwise.
    public let edited: Bool?
    
    
    /**
        For newer posts, this will be the date UTC epoch-seconds. Old comments, this
        will be `nil`
    */
    public let editedDate: Int?
    
    /// the number of times this comment received reddit gold
    public let gilded: Int?
    
    /**
		how the logged-in user has voted on the comment - `True` = upvoted, `False` =
		downvoted, `nil` = no vote
    */
    public let likes: Bool?
    
    /// the number of upvotes. (includes own)
    public let ups: Int?
    
    /// the number of downvotes. (includes own)
    public let downs: Int?
    
    /**
        Present if the comment is being displayed outside its thread (user pages, etc)
        Contains the author of the parent link.
    */
    public let linkAuthor: String?
    
    /// ID of the link this comment is in
    public let linkID: String?
    
    /**
    	Present if the comment is being displayed outside its thread (user pages, etc)
    	Contains the title of the parent link.
    */
    public let linkTitle: String?
    
    /// ID of the link this comment is in
    public let linkURL: String?
    
    /// how many times this comment has been reported, `nil` if not a mod
    public let numReports: Int?
    
    /// ID of the thing this comment is a reply to, either the link or a comment in it
    public let parentId: String?
    
    /// A list of replies to this comment
    public let replies: Listing?
    
    /// `true` if this post is saved by the logged in user
    public let saved: Bool?
    
    /// the net-score of the comment
    public let score: Int?
    
    /// Whether the comment's score is currently hidden.
    public let scoreHidden: Bool?
    
    /// subreddit of thing excluding the /r/ prefix.
    public let subreddit: String?
    
    /// the id of the subreddit in which the thing is located
    public let subredditId: String?
    
    /**
        to allow determining whether they have been distinguished by 
        moderators/admins. `nil` = not distinguished. `moderator` = the green [M].
        `admin` = the red [A]. special = various other special distinguishes defined
        [here](http://redd.it/19ak1b)
    */
    public let distinguished: String?
    
    /**
     initialize an `Comment` object
     
     - parameter data: JSON data from the API endpoint
     
     - returns: an `Comment` object.
     */
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
        self.ups = data["ups"].int
        self.downs = data["downs"].int
        self.linkAuthor = data["link_author"].string
        self.linkID = data["link_id"].string
        self.linkTitle = data["link_title"].string
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