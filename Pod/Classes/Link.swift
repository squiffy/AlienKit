//
//  Link.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Link: Thing {
    
    /// <#Description#>
    public let created: Int?
    
    /// <#Description#>
    public let createdUTC: Int?
    
    
    /// the account name of the poster. `nil` if this is a promotional link
    public let author: String?
    
    /// the CSS class of the author's flair. subreddit specific
    public let authorFlairCSSClass: String?
    
    /// the text of the author's flair. subreddit specific
    public let authorFlairText: String?
    
    /// probably always returns false. that is all that reddit (says about it)[https://github.com/reddit/reddit/wiki/JSON]
    public let clicked: Bool?
    
    /// domain of the link. if its a self post, it will be `self.<subreddit>`
    public let domain: String?
    
    /// `true` if the post is hidden by the logged in user. `false` if not logged in or not hidden.
    public let hidden: Bool?
    
    /// `true` if this link is a selfpost
    public let isSelf: Bool?
    
    /**
     how the logged-in user has voted on the comment - `True` = upvoted, `False` =
     downvoted, `nil` = no vote
     */
    public let likes: Bool?
    
    /// the number of upvotes. (includes own)
    public let ups: Int?
    
    /// the number of downvotes. (includes own)
    public let downs: Int?
    
    /// the CSS class of the link's flair.
    public let linkFlairCSSClass: String?
    
    /// the text of the link's flair.
    public let linkFlairText: String?
    
    /// whether the link is locked (closed to new comments) or not.
    public let locked: Bool?
    
    /// Used for streaming video. Detailed information about the video and it's origins are placed here
    public let media: Media?
    
    /// Used for streaming video. Technical embed specific information is found here.
    public let previewImages: [PreviewImage]?
    
    /// the number of comments that belong to this link. includes removed comments.
    public let numComments: Int?
    
    /// true if the post is tagged as NSFW. False if otherwise
    public let over18: Bool?
    
    /// relative URL of the permanent link for this link
    public let permalink: String?
    
    /// true if this post is saved by the logged in user
    public let saved: Bool?
    
    /// the net-score of the link
    public let score: Int?
    
    /// the raw text. this is the unformatted text which includes the raw markup characters such as `**` for bold. `<`, `>`, and `&` are escaped. Empty if not present.
    public let selfText: String?
    
    /**
     the formatted HTML text as displayed on reddit. For example, text that is
     emphasised by `*` will now have `<em>` tags wrapping it. Additionally,
     bullets and numbered lists will now be in HTML list format. **NOTE**: The
     HTMLstring will be escaped. You must unescape to get the raw HTML.
     */
    public let selfTextHTML: String?
    
    /// subreddit of thing excluding the /r/ prefix.
    public let subreddit: String?
    
    /// the id of the subreddit in which the thing is located
    public let subredditId: String?
    
    /// full URL to the thumbnail for this link; "self" if this is a self post; "default" if a thumbnail is not available
    public let thumbnail: String?
    
    /// the title of the link. may contain newlines for some reason
    public let title: String?
    
    /// the link of this post. the permalink if this is a self-post
    public let url: String?
    
    /// Indicates if link has been edited. Will be the edit timestamp if the link has been edited and `nil` otherwise
    public let edited: Int?
    
    /**
     to allow determining whether they have been distinguished by
     moderators/admins. `nil` = not distinguished. `moderator` = the green [M].
     `admin` = the red [A]. special = various other special distinguishes defined
     [here](http://redd.it/19ak1b)
     */
    public let distinguished: String?
    
    /// `true` if the post is set as the sticky in its subreddit.
    public let stickied: Bool?
    
    /**
     initialize a `Link` object
     
     - parameter data: JSON data from the API endpoint
     
     - returns: a `Link` object.
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