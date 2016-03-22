//
//  PreviewImage.swift
//  Pods
//
//  Created by Will Estes on 3/21/16.
//
//

import Foundation
import SwiftyJSON

public class Image {
    public let url: String?
    public let width: Int?
    public let height: Int?
    
    init(data: JSON?) {
        self.url = data?["url"].string
        self.width = data?["width"].int
        self.height = data?["height"].int
    }
}

public class PreviewImage {
    
    let source: Image?
    let resoulutions: [Image]?
    
    
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