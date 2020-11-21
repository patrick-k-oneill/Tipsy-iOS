//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Patrick O'Neill on 11/2/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // Contains individualTotal, numberOfPeople, and tipPercentage values (passed from CalculatorView) to display results
    var bill = Bill()
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    
    // Displays calculated bill results
    override func viewDidLoad() {
        totalLabel.text = String(format:"%.2f", bill.individualTotal)
        settingsLabel.text = "Split between \(bill.numberOfPeople) people, with a \(Int(bill.tipPercentage * 100))% tip."
    }
    
    // User presses "Recalculate" -> Dismisses resultsView -> User can reinput data into CalculatorView
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
