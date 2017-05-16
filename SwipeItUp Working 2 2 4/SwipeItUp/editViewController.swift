//
//  editViewController.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/1/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit
import NotificationCenter
class editViewController: UIViewController , DataEnteredDelegate , DataEnteredDelegatee
{
    var myDate : String = ""
    @IBOutlet weak var daySwitch: UISwitch!
   
    //var events = eventStorage()
    @IBOutlet weak var repeadtEvery: UILabel!
    
    @IBOutlet weak var dayText: UILabel!
    @IBOutlet weak var not: UILabel!
    @IBOutlet weak var priori: UILabel!
    @IBOutlet weak var loc: UILabel!
    var events:eventStorage!
    @IBOutlet weak var taskName: UILabel!
    
    @IBOutlet weak var dayTextfield: UITextField!
   
    @IBOutlet weak var selectedDate: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dayPicker: UIPickerView!
    
   // @IBOutlet weak var priority: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
//    @IBOutlet weak var prioirityPicker: UIPickerView!
    
    @IBOutlet weak var notes: UITextField!

    @IBOutlet weak var myslider: UISlider!
    
    @IBOutlet weak var priorlab: UILabel!
    
     var slidervar : String = ""
    
    var toPass : String = ""
    var oldEvent: event!
    
   // var priorityList = ["* * *","* *", "*","None"]
    

    
    @IBAction func moveslider(sender: AnyObject) {
        let c = myslider.value
        
        if(c < 30)
        {
            slidervar = "low"
        } else if(c >= 31 && c <= 70)
        {
            slidervar = "medium"
        }
        else
        {
            slidervar = "high"
        }
        
        
        priorlab.text = "\(slidervar)"
        
        
        
    }
        @IBAction func datePickerAction(sender: AnyObject) {
    
        let df=NSDateFormatter()
        df.dateFormat="dd-MM-yyyy HH:mm"
        let dateS=df.stringFromDate(datePicker.date)
        self.selectedDate.text=dateS        
    }
    
   weak var delegate: TimeEnteredDelegate? = nil

    @IBAction func setTask(sender: AnyObject) {
    
        var time = selectedDate.text!
        var day = dayText.text!
        
        var locate = location.text!
        var note = notes.text!
        let prio = priorlab.text!
        
        if (day == "") {
            day = "None"
        }
        if(locate == ""){
            locate = " "
        }
        if(note == ""){
            note = "You have no notes"
        }
        if(time == ""){
            time = " "
        }
        
    
        let obj = ["\(time)" , "\(day)" , "\(locate)" , "\(prio)", "\(note)"]
        
        
        
        events.dict[taskName.text!] = ["\(time)" , "\(day)" , "\(locate)" , "\(prio)", "\(note)"]
        print(taskName.text!)
        print(events.dict)
        
        PermanentStorage.pushData(taskName.text!, object: obj)
        print("Premanent Storage is \(PermanentStorage.pullData(taskName.text!))")
       // PermanentStorage.pushData();
//        
//        delegate?.userInfo(selectedDate.text!)
//        

//    
//        // go back to the previous view controller
//        _ = self.navigationController?.popViewControllerAnimated(true)
//        
        
       // print((PermanentStorage.pullData(taskName.text!)));
      //print(events.dict)
        
    }
    
    
    @IBOutlet weak var switchNotification: UISwitch!
        
    @IBAction func toggleSwitch(sender: UISwitch) {

    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueFromEditToReminder" {
            let secondViewController = segue.destinationViewController as! setReminderViewController
            secondViewController.delegate = self
            
            
            let goTo = segue.destinationViewController as! setReminderViewController
           
            goTo.task = (taskName.text)!
            
            
            switchNotification.on = false
        }
        else if segue.identifier == "segueFromDayToEdit" {
            let viewController = segue.destinationViewController as! dayViewController
            viewController.delegate = self
            daySwitch.on = false
        }
        
        if(segue.identifier == "segueFromHomeToEdit" ){
            
            //let cell = tableView.cellForRowAtIndexPath(<#T##indexPath: NSIndexPath##NSIndexPath#>)
            _ = segue.destinationViewController as! homeViewController
                  }

    }
   
    
    
    func userDidEnterInformation(info: String) {
        selectedDate.text = info
    }
    
    func userInfo(info: String){
        dayText.text = info
    }

    
    @IBAction func dateChanged(sender: UIDatePicker) {

    }
    

    
    var item: event! {
        didSet {
            //sets the title property of navigationItem to show the name of the item on the navigation bar of the DetaiLViewController
            navigationItem.title = item.name
        }
    }

    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController's view will appear blahhh")
        //  selectedDate.text = events.dict
        let keyName = toPass
        print("KEY NAME ; \(keyName)")
        print("retrieving Info");
        
        taskName.text = toPass
        
        for (key,value) in events.dict {
            if (key == keyName) {
                
                var vals = Array(value)
                
                selectedDate.text = vals[0] as? String
                dayText.text = vals[1] as? String
                location.text = vals[2] as? String
                priorlab.text = vals[3] as? String
                notes.text = vals[4] as? String
                
//                else {
//                    if(
//                    selectedDate.text = "09-12-2016 10:00"
//                    dayText.text = "Every Tuesday"
//                    location.text = "LCS Building"
//                      priorlab.text =  "HIGH"
//                    notes.text = "Presentation is on Dec 9"
//                }
                
            }
        }
        
    }

    
    override func viewDidLoad() {
//        let appDomain = NSBundle.mainBundle().bundleIdentifier!
//        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        super.viewDidLoad()
       // scroller.contentSize = CGSizeMake(400, 2300)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(editViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(editViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);

        taskName.text = toPass
       // datePicker.hidden = true ;
        switchNotification.on = false;
        daySwitch.on = false
      
        let keyName = taskName.text
        
        for(key,value) in events.dict {
            if(key == keyName) {
                //var values = Array(events.dict.values)
                print("\(key) -> \(value)")
            }
           }
        self.hideKeyboard()
        
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        let   cell = tableView.dequeueReusableCellWithIdentifier("addNewTaskCell") as! addNewTask
//        //cell. //sets the fonts of the labels
//        cell.taskName.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//      func noOfComponentsInPickerView (pickerView : UIPickerView) ->Int {
//        return 1
//    }
//    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

protocol  TimeEnteredDelegate : class {
    func userInfo(info: String)
}

