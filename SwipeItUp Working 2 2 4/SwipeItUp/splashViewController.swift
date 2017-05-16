//
//  splashViewController.swift
//  SwipeItUp
//
//  Created by Nishtha Goel on 12/6/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit

class splashViewController : UIViewController {
    
    
     override func viewDidLoad() {
        
        super.viewDidLoad()
        
            print("Initial")
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                
                
                        print("test")
                        // User is signed in.
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("first")
                        self.presentViewController(nextViewController, animated: true, completion: nil)
                           }
    }
    
    
}
