//
//  ViewController.swift
//  HWCalculatorApp
//
//  Created by Alisher on 9/15/19.
//  Copyright © 2018 Alisher. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myDisplay: UILabel!
    var typing : Bool = false
    @IBAction func digitPressed(_ sender: UIButton) {
        if typing{
            let current_display = myDisplay.text!
            let current_title_of_button = sender.currentTitle!
            myDisplay.text = current_display + current_title_of_button
        }else{
            myDisplay.text = sender.currentTitle!
            typing = true
        }
    }
    var displayValue: Double{
        get{
            return Double(myDisplay.text!)!
        }
        set{
            myDisplay.text = String(newValue)
        }
    }
    private var myModel = CalculatorModel()
    @IBAction func operationPressed(_ sender: UIButton) {
        if typing{
            myModel.setOperand(displayValue)
            typing = false
        }
    myModel.performOperation(sender.currentTitle!)
        if let result = myModel.result{
            displayValue = result
        }
    }
    
    @IBAction func erasePressed(_ sender: UIButton) {
        myModel.clear()
        displayValue = 0
        typing = false
        myDisplay.text = "0"
    }
}



