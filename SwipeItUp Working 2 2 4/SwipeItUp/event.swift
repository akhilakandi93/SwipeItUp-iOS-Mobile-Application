//
//  event.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/1/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit

class event: NSObject{
    //, NSCoding
    var name : String!
    var time : String!
    var day : String!
    var location: String!
    var priority : String!
    var notes : String!
    
    
    init(name : String ) {
        self.name = name
       
        
    }

    
    init(name : String , time : String) {
    self.name = name
        self.time = time
    }
    
    init(name : String , time : String , day : String , location : String, priority : String , notes : String) {
        self.name = name
        self.time = time;
        self.day = day
        self.location = location
        self.priority = priority
        self.notes = notes
    }
    
    convenience init(random: Bool) {
       
        //let df=NSDate()
        if random {
           // self.init(name: "",time: df , day: "",location: "", priority: "", notes: "" )
        }
        
        
        self.init(name: "",time: "" , day: "",location: "", priority: "", notes: "" )
    }
    
//    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(name, forKey: "name")
//        aCoder.encodeObject(time,forKey:  "time")
//        aCoder.encodeObject(day,forKey:  "day")
//        aCoder.encodeObject(location,forKey:  "location")
//        aCoder.encodeObject(priority,forKey: "priority")
//        aCoder.encodeObject(notes,forKey:  "notes")
//    }
//    
//    required init(coder aDecoder:NSCoder) {
//        name = aDecoder.decodeObjectForKey("name") as! String
//        time = aDecoder.decodeObjectForKey("time") as! NSDate
//        day = aDecoder.decodeObjectForKey("day") as! String
//        location = aDecoder.decodeObjectForKey("location") as! String
//        priority = aDecoder.decodeObjectForKey("priority") as! String
//        notes = aDecoder.decodeObjectForKey("notes") as! String
//        
//        super.init()
//    }
    
    
}
