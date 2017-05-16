//
//  dayViewController.swift
//  SwipeItUp
//
//  Created by Akhila Kandi on 12/5/16.
//  Copyright © 2016 Akhila Kandi. All rights reserved.
//
//thissssssssss
import UIKit

class dayViewController : UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {
    var dayList = ["None", "Every Week", "Every 2 Weeks", "Every Month" , "Every Year"]
    weak var delegate: DataEnteredDelegatee? = nil
    
    @IBOutlet weak var dayPicker: UIPickerView!

    @IBOutlet weak var selectedDay: UILabel!


    @IBAction func setDay(sender: AnyObject) {
        
        delegate?.userInfo(selectedDay.text!)
        
        // go back to the previous view controller
        _ = self.navigationController?.popViewControllerAnimated(true)
        
    }
 @IBAction func unwindBackToEditViewController(segue: UIStoryboardSegue){
    
    
    }
    
    func numberOfComponentsInPickerView (pickerView : UIPickerView) ->Int {
        return 1
    }
    
    func pickerView(pickerView : UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayList.count
    }
    
    func  pickerView(pickerView: UIPickerView, titleForRow row: Int , forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return dayList[row]
    }
    
    func pickerView (pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.selectedDay.text = self.dayList[row]
        self.dayPicker.hidden = false
    }
    
    func textFieldDidBeginEditing (textField: UITextField) {
        if textField == self.selectedDay {
            self.dayPicker.hidden = false
            textField.endEditing(true)
        }
    }
    
    override func viewDidLoad() {
        self.dayPicker.dataSource = self
        self.dayPicker.delegate = self
    }
    

}

protocol  DataEnteredDelegatee : class {
    func userInfo(info: String)
}
