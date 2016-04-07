//
//  PreviewImage.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

/// Reddit Image object
public class Image {
    
    /// url of the image
    public let url: String?
    
    /// width of the image
    public let width: Int?
    
    /// height of the image
    public let height: Int?
    
    /**
     initializer for an `Image` object
     
     - parameter data: image JSON
     
     - returns: a new `Image` object.
     */
    init(data: JSON?) {
        self.url = data?["url"].string
        self.width = data?["width"].int
        self.height = data?["height"].int
    }
}

/// Reddit `PreviewImage` object.
public class PreviewImage {
    
    /// source resolution of the image.
    public let source: Image?
    
    /// array of various resolutions of the original source image.
    public let resoulutions: [Image]?
    
    /**
     initialize a `PreviewImage` object
     
     - parameter data: JSON data from the API endpoint
     
     - returns: a `Media` object.
     */
    init(data: JSON) {
        self.source = Image(data: data["source"])
        
        if let images = data["resolutions"].array {
            var tempImages = [Image]()
            
            for image in images {
                tempImages.append(Image(data: image))
            }
            
            self.resoulutions = tempImages
            
        } else {
            self.resoulutions = nil
        }
        
    }
    
}