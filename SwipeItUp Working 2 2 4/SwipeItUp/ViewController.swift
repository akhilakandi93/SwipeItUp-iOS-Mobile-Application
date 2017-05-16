//
//  ViewController.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/1/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //set contentInset for tableView
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
    
        tableView.contentInset = insets
        
        //tableView.rowHeight = 45
        
        tableView.estimatedRowHeight = 65
        
        print("font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

