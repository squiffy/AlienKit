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
            self.client!.getPostsFrom("all", success: { listing in
                for thing in listing.things {
                    
                    if let thing = thing as? Link {
                        print(thing.permalink)
                    }

                }
                
                print("===================================")
                self.client!.getPostsFrom("all", after: listing, success: { listing in
                    
                    for thing in listing.things {
                        
                        if let thing = thing as? Link {
                            print(thing.permalink)
                        }
                        
                    }
                    
                    }, failure:  {
                        print("something went wrong")
                })
                
                }, failure:  {
                    print("something went wrong")
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
