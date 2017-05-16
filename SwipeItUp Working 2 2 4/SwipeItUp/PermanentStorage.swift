//
//  PermanentStorage.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/2/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit

class PermanentStorage: NSObject {
   
    internal static func pushData(key:String,object:AnyObject){
//        let appDomain = NSBundle.mainBundle().bundleIdentifier!
//        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
//
      
        NSUserDefaults.standardUserDefaults().setObject(object, forKey: key+"redblue")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
    }
    
    internal static func pullData(key:String)->AnyObject{
        if NSUserDefaults.standardUserDefaults().objectForKey(key) != nil  {
        return NSUserDefaults.standardUserDefaults().objectForKey(key)!
        }
        return 1
    }
    
}
