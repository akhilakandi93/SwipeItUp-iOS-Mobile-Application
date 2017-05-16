//
//  eventStorage.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/1/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit

class eventStorage {
    var events=[event]()
    var listOfEvents = [String : event]()
    var dat = NSDate()
    var s : String = "Heylo"
   
  
    var dict: Dictionary<String, NSArray> = [:]
        //["MAP Assignment" : ["09-12-2016 10:00", "Every Tuesday" , "LCS Building" ,"Low", "Presentation is on Dec 9"]]
//    let itemArchiveURL: NSURL = {_ in
//        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//        let documentDirectory = documentsDirectories.first!
//        return documentDirectory.URLByAppendingPathComponent("items.archive")
//    }()
//    

    
    func createEvent()->event{
        let newTask = event(name : "")
        let addItem = event(name: "", time : "")
        events.append(newTask)
        
        return addItem
    }
    
 
    func removeEvent ( Event : String){
        print("PRINTING DICTIONARY AFTER DELETING")
        print(dict)
        dict.removeValueForKey(Event)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Event+"redblue")
        NSUserDefaults.standardUserDefaults().synchronize()
        for (key, value) in NSUserDefaults.standardUserDefaults().dictionaryRepresentation() {
            print("\(key) = \(value) \n")
            
        }

    }
    
    
    
    func printEvents() {
        for i in 0..<events.count{
            print("name: \(events[i].name) time: \(events[i].time) day: \(events[i].day) priority: \(events[i].priority) notes: \(events[i].notes)" )
        }
    }
    
}
