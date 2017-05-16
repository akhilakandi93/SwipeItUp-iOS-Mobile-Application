//
//  setReminderViewController.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/5/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//
import EventKit
import UIKit
import NotificationCenter


class setReminderViewController : UIViewController {
    var events:eventStorage!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!
    var savedEventId : String = ""
    var task : String = ""
    @IBAction func datePicker(sender: AnyObject) {
        
        let df=NSDateFormatter()
        df.dateFormat="dd-MM-yyyy HH:mm"
        let dateS=df.stringFromDate(datePicker.date)
        self.selectedDate.text=dateS
        
        
        var datecom:NSDateComponents = NSDateComponents()
        datecom.timeZone = NSTimeZone.defaultTimeZone()
        var calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var date : NSDate = calendar.dateFromComponents(datecom)!
        
        let notification = UILocalNotification()
        notification.alertTitle = "Task overdue!!"
        notification.alertBody = "You are to complete a task in SwipeItUp"
        notification.fireDate = datePicker.date
        notification.applicationIconBadgeNumber = 1
        notification.timeZone = nil
        notification.soundName = UILocalNotificationDefaultSoundName
        print("******")
        print(datePicker.date)
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        

        
    }
    weak var delegate: DataEnteredDelegate? = nil
    
    @IBAction func setReminder(sender: AnyObject) {
    
        delegate?.userDidEnterInformation(selectedDate.text!)
        
        // go back to the previous view controller
        _ = self.navigationController?.popViewControllerAnimated(true)
        
        
        
        
    }
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
        let event = EKEvent(eventStore: eventStore)
        print("i am in create event--------")
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }
    
    @IBAction func addEvent(sender: UIButton) {
        print("%%%%%%%")
        let eventStore = EKEventStore()
        var startDate = datePicker.date
        
        //   let startDate = datePicker.date
        let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                self.createEvent(eventStore, title: self.task, startDate: startDate, endDate: endDate)
            })
        } else {
            createEvent(eventStore, title: task, startDate: startDate, endDate: endDate)
        }
    }
    func deleteEvent(eventStore: EKEventStore, eventIdentifier: String) {
        
        let eventToRemove = eventStore.eventWithIdentifier(eventIdentifier)
        
        if (eventToRemove != nil) {
            
            do {
                
                try eventStore.removeEvent(eventToRemove!, span: .ThisEvent)
                
            } catch {
                
                print("Bad things happened")
                
            }
            
        }
        
    }
    
    @IBAction func removeEventCal(sender: UIButton) {
        
        let eventStore = EKEventStore()
        
        
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                
                self.deleteEvent(eventStore, eventIdentifier: self.savedEventId)
                
            })
            
        } else {
            
            deleteEvent(eventStore, eventIdentifier: savedEventId)
            
        }
        
        
        
        
    }

    
    @IBAction func unwindToeEditViewController(segue: UIStoryboardSegue){
//        
//        if let secondViewController =
//            unwindSegue.sourceViewController as? setReminderViewController {
//            selectedDate.text = setReminderViewController.selectedDate.text
//        }
        
    }
    
    
         let localNotification = UILocalNotification()
        
        func setUpNotificationsOptions()  {
            datePicker.datePickerMode = .Time
            localNotification.timeZone = NSTimeZone.localTimeZone()
            localNotification.repeatInterval = .Day
            localNotification.alertAction = "Open App"
            localNotification.alertBody = "a notification"
            localNotification.soundName = UILocalNotificationDefaultSoundName
        }
        
        func toggleNotification() {
           
                localNotification.fireDate = datePicker.date.fireDate
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
           
        }

        
        
  
}


protocol  DataEnteredDelegate : class {
    func userDidEnterInformation(info: String)
}

extension NSDate {
    var minute: Int {
        return NSCalendar.currentCalendar().component(.Minute, fromDate: self)
    }
    var hour: Int {
        return NSCalendar.currentCalendar().component(.Hour, fromDate: self)
    }
    var day: Int {
        return NSCalendar.currentCalendar().component(.Day, fromDate: self)
    }
    var month: Int {
        return NSCalendar.currentCalendar().component(.Month, fromDate: self)
    }
    var year: Int {
        return NSCalendar.currentCalendar().component(.Year, fromDate: self)
    }
    var fireDate: NSDate {
        let today = NSDate()
        return NSCalendar.currentCalendar().dateWithEra(1,
                                                        year: today.year,
                                                        month: today.month,
                                                        day: { hour > today.hour || (hour  == today.hour
                                                            &&  minute > today.minute) ? today.day : today.day+1 }(),
                                                        hour: hour,
                                                        minute: minute,
                                                        second: 0,
                                                        nanosecond: 0
            )!
    }
}




