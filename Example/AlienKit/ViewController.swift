//
//  ViewController.swift
//  AlienKit
//
//  Created by Squiffy on 03/17/2016.
//  Copyright (c) 2016 Squiffy. All rights reserved.
//

import UIKit
import AlienKit

class ViewController: UIViewController {
    
    var client :UserlessClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.client = UserlessClient(id: "YwBLaxHJevLYPg")
        
        client!.authenticate({
            self.client!.getPostsFrom("drugs", success: { listing in
                
                for thing in listing.things {
                    
                    if let thing = thing as? Link {
                        // now get comments
                        self.client!.getCommentsFor(thing, success: { listing in
                            
                            for thing in listing.things {
                                
                                if let thing = thing as? Comment {
                                    print(thing.body)
                                }
                            }
                            
                            }, failure: {
                                
                                print("could not get comments")
                        })
                        
                    }
                    
                }
                
                }, failure: {
                    
                    print("could not get posts.")
                    
                })
            
            }, failure: { _ in
                
                print("could not auth")
                
        })
        
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
