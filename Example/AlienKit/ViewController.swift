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
    
    var client :Client?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.client = Client(id: "YwBLaxHJevLYPg", completion: { client, error in
            if let _ = client {
                print("we've logged in!")
            } else {
                if let error = error {
                    print(error)
                }
            }
        })
        
        print(client)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
