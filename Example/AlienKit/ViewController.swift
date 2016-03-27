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

        client!.authorize({
            
            self.client!.getPostsFrom("apple", success: { listing in
                
                for thing in listing.things {
                    if let link = thing as? Link {
                        print(link.title)
                    }
                }
                
                if let thing = listing.things[0] as? Link {
                    self.client!.getCommentsFor(thing, sort: .Top, success: { listing in
                        
                        if let thing = listing.things[0] as? Comment {
                            print(thing.body!)
                            
                            if let subThing = thing.replies?.things[0] as? Comment {
                                print(subThing.body!)
                            }
                        }
                        
                        }, failure: {
                            
                    })
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
