//
//  homeViewController.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/1/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//

import UIKit

class homeViewController :UIViewController, UITableViewDelegate, UITableViewDataSource , TimeEnteredDelegate {
    
    var tableView:UITableView!
    var eventStore = eventStorage()
    var userDictKeyCopy:[String] = []
    var dictOfTimes:[String] = []
    var refreshControl: UIRefreshControl!
   
    override func viewDidLoad() {

        super.viewDidLoad()
//        let appDomain = NSBundle.mainBundle().bundleIdentifier!
//        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
//

        //to move the screen up to make the text visible
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homeViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homeViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);

        
        tableView =  (self.view.viewWithTag(7) as! UITableView)
        tableView.dataSource = self
        tableView.delegate = self
        for (key, value) in NSUserDefaults.standardUserDefaults().dictionaryRepresentation() {
            print("\(key) = \(value) \n")
            if key.rangeOfString("redblue") != nil{
      var key1 = key.substringWithRange(Range<String.Index>(start: key.startIndex.advancedBy(0), end: key.endIndex.advancedBy(-7)))
                eventStore.dict[key1] = value as? NSArray
            }
            
                     print("Akhila  \(eventStore.dict)")
        }
        tableView.backgroundView = nil
//      tableView.backgroundColor = UIColor(red: 88.0/255.0, green: 97.0/255.0, blue: 98.0/255.0, alpha: 1.0)
      self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 188.0/255.0, blue: 212.0/255.0, alpha: 1.0);
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
          userDictKeyCopy = Array(eventStore.dict.keys)
        
        print("UserDictCopy is \(userDictKeyCopy)")
   
        navigationItem.title = "SwipeItUp"
//        eventStore.dict["NSLanguages"] = ["10-12-2016 10:00", "Every Tuesday" , "LCS Building" ,"Low", "Presentation is on Dec 9"]
//        eventStore.dict["AppleKeyboards"] = ["01-09-2016 13:30", "Every Thursday" , "Bird Lib" ,"Low", "No Notes"]
//        eventStore.dict["AppleITunesStoreItemKinds"] = ["21-12-2016 09:20", "Every Tuesday" , "LCS Building" ,"Low", "Presentation is on Dec 9"]
//        eventStore.dict["AppleLanguages"] = ["09-01-2016 10:28", "None" , "LCS Building" ,"Low", "No notes"]
//         eventStore.dict["ApplePasscodeKeyboards"] = ["12-01-2016 7:28", "None" , "CST 4-201" ,"medium", "No notes"]
        
        
        //code for pull to refresh
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        //end of code pull to refres
        
        self.refreshControl?.addTarget(self, action: #selector(homeViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        print("font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        self.hideKeyboard()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
   
    func refresh(sender:AnyObject) {
        
        for (key, value) in NSUserDefaults.standardUserDefaults().dictionaryRepresentation() {
            print("\(key) = \(value) \n")
            if key.rangeOfString("redblue") != nil{
                var key1 = key.substringWithRange(Range<String.Index>(start: key.startIndex.advancedBy(0), end: key.endIndex.advancedBy(-7)))
                eventStore.dict[key1] = value as? NSArray
            }
            
            print("Akhila  \(eventStore.dict)")
        }
        
        
        
        
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue , sender : AnyObject!) {
        if(segue.identifier == "segueFromHomeToEdit" ){
            
            //let cell = tableView.cellForRowAtIndexPath(<#T##indexPath: NSIndexPath##NSIndexPath#>)
            let goTo = segue.destinationViewController as! editViewController
           // var ter = self.tableView.viewWithTag(25) as! UITextField
            
            //goTo.toPass = ter.text!
            goTo.events = eventStore
            
            
            goTo.delegate = self
            let indexPath = tableView.indexPathForSelectedRow
            print(" Akhila \(indexPath?.row)")
            let m1 = ((tableView.cellForRowAtIndexPath(indexPath!))?.viewWithTag(13) as! UITextField)

            
            goTo.toPass = (m1.text)!

        }
        
    }
    
    func userInfo(info: String){
         let indexPath = tableView.indexPathForSelectedRow
        let time = ((tableView.cellForRowAtIndexPath(indexPath!))?.viewWithTag(36) as! UILabel)
             time.text! = info
    }
    
    func userInformation (taskName: String){
        let indexPath = tableView.indexPathForSelectedRow
        //let time = ((tableView.cellForRowAtIndexPath(indexPath!))?.viewWithTag(36) as! UILabel)
        let task = ((tableView.cellForRowAtIndexPath(indexPath!))?.viewWithTag(13) as! UITextField)
        task.text! = taskName
       // time.text! = info
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        tableView.reloadData()
         userDictKeyCopy = Array(eventStore.dict.keys)
        self.refreshControl?.addTarget(self, action: #selector(homeViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.endRefreshing()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return userDictKeyCopy.count
       // return eventStore.dict.count
        
    }
    
    //function to get a cell for inserting in a particular location of the table view. This is a REQUIRED function
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("addNewTaskCell", forIndexPath: indexPath) as! addNewTaskCell
         cell.timeLabel.text = ""
        cell.taskName.text = self.userDictKeyCopy[indexPath.row]
        print(self.userDictKeyCopy[indexPath.row]);
        let key = self.userDictKeyCopy[indexPath.row]
        if let obj = eventStore.dict[key] {
            if let ambiguousData = obj[0] as? String {
                cell.timeLabel.text = ambiguousData
            }
            }

         return cell
       
        }
   
    
   @IBAction func addTask(button: UIButton) {
    userDictKeyCopy.append("");
    
    dispatch_async(dispatch_get_main_queue(),{ ()->() in
        self.tableView.reloadData()
    })
 //let index = 0
//    if newItem = eventStore.createEvent()
//    if let index = userDictKeyCopy.indexOf(newItem)
    
    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

    
    }
  
    
    @IBAction func editButtonAction(button: UIButton) {
    
        if tableView.editing {
            tableView.editing = false
            button.setTitle("Edit", forState: .Normal)
            
        }
        else {
            tableView.editing = true
            //            setEditing(true, animated: true)
            button.setTitle("Done", forState: .Normal)
        }
    }
    
 
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
      //  print("&&&&&&&&&&")
        
        print("&&&&&&&&&&")
        
        if editingStyle == .Delete {
            
//                        let index = tableView.indexPathForSelectedRow
//                        print(" Akhila \(index?.row)")
//                        let m1 = ((tableView.cellForRowAtIndexPath(index!))?.viewWithTag(13) as! UITextField)
            print("&&&&&&&&&&")
            //
            //            let item = m1.text
            // let item = eventStore.events[indexPath.row]
            let item = self.userDictKeyCopy[indexPath.row]
            
            let title = "Delete ?"
            
            let message = "Are you sure?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete",
                                             style: .Destructive,
                                             handler: {_ in
                                                self.userDictKeyCopy.removeAtIndex(indexPath.row)
                                                self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forItem: indexPath.row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Left)
                                                
            })
             eventStore.removeEvent(item)
            ac.addAction(deleteAction)
//            var i : Int = 0
//            for key in userDictKeyCopy {
//                if key == item {
//                    userDictKeyCopy.removeAtIndex(i)
//                }
//                i = i + 1
//            }
            
            presentViewController(ac, animated: true, completion: nil)
            
        }
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }

    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
     return UITableViewCellEditingStyle.Delete
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue){
        
        
        
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(homeViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let   cell = tableView.dequeueReusableCellWithIdentifier("addNewTaskCell") as! addNewTaskCell
        //cell. //sets the fonts of the labels
        cell.taskName.resignFirstResponder()
        return true
    }


 func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     //let cell = tableView.cellForRowAtIndexPath(indexPath)
          print("You selected cell #\(indexPath.row)!")
       tableView.deselectRowAtIndexPath(indexPath, animated: true)
      // performSegueWithIdentifier("segueDescription", sender: cell)
   }
   
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -80
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}


//extension Dictionary {
//    mutating func changeKey(from: Key , To: Key){
//        self[To] = self[from]
//        self.removeValueForKey(from)
//    }
//    
//}