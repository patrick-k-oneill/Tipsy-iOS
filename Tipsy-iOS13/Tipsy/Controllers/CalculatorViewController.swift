//
//  ViewController.swift
//  Tipsy
//
//  Created by Patrick O'Neill on 11/02/2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    //Create a bill struct for storing tip, bill, & split values
    var bill = Bill()
    
    //Create a struct for formatting and retrieving values from the input text field
    var billFormatter = BillFormatter()
    
    //User enters value into text field -> converts value (real time) into currency style
    @IBAction func billValueChanged(_ sender: UITextField) {
        
        //Remove (possible) red border
        billTextField.layer.borderWidth = 0.0
        billTextField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        billTextField.text = billFormatter.formatTextField(text: billTextField.text)
    }
    
    
    // User presses tip % -> unselects all tip % buttons -> selects user-pressed tip % button & updates value
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //Dismisses keyboard
        billTextField.endEditing(true)
        
        switch sender   {
        case zeroPctButton:
            sender.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            bill.tipPercentage = 0.0
        case tenPctButton:
            sender.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
            bill.tipPercentage = 0.1
        case twentyPctButton:
            sender.isSelected = true
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            bill.tipPercentage = 0.2
        default:
            return
        }
    }
    
    // User presses '+' or '-' stepper buttons -> updates split label and numberOfPeople value
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        bill.numberOfPeople = Int(sender.value)
    }
    
    // User presses "Calculate" button -> sets billTotal value, calculates individualTotal value, and segues to result view (Or, if text field is empty -> outlines text field in red)
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        //If text field has input, calculate totals and segue to ResultsView.  Else, if empty, outline text field in red
        if billTextField.text != Optional("") {
            bill.billTotal = billFormatter.getBillTotal(text: billTextField.text!)!
            bill.setIndividualTotal()
            performSegue(withIdentifier: "goToResult", sender: self)
            
        } else {
            billTextField.layer.borderWidth = 2.0
            billTextField.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    // Instructs segue to create ResultsView--passes individualTotal, numberOfPeople, and tipPercentage to ResultsView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bill = bill
        }
    }
}

