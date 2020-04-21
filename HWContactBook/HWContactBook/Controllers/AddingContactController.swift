//
//  AddingContactController.swift
//  HWContactBook
//
//  Created by Alisher on 9/23/19.
//  Copyright © 2019 Alisher. All rights reserved.
//

import Foundation
import UIKit
class AddingContactController: UIViewController {
    
    @IBOutlet weak var new_name_lbl: UITextField!
    @IBOutlet weak var new_phone_lbl: UITextField!
    @IBOutlet weak var new_pickerView: UIPickerView!
    
    var pustoi = ""
    var netuNomera = ""
    var value = "male"
    let gender = ["male", "female"]
    var receiver: Receiver?
    
    @IBAction func add_new_contact(_ sender: UIButton) {
        if new_name_lbl.text! == pustoi {
            let alert = UIAlertController(title: "SOS", message: "Add contact's name and surname", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else if Int(new_phone_lbl.text!) == Int(netuNomera) {
            let alert = UIAlertController(title: "SOS", message: "Add contact's phone number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            if value == "male" {
                receiver?.save(a: Contact(UIImage.init(named: "male")!, new_name_lbl.text!, new_phone_lbl.text!))
            } else {
                receiver?.save(a: Contact(UIImage.init(named: "female")!, new_name_lbl.text!, new_phone_lbl.text!))
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddingContactController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        value = gender[row]
    }
}

