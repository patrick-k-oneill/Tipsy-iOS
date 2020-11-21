//
//  Bill.swift
//  Tipsy
//
//  Created by Patrick O'Neill on 11/6/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

var billFormatter = BillFormatter()

//Contains properties, methods for storing & calculating bill totals
struct Bill {
    
    var tipPercentage : Float = 0.1
    var numberOfPeople = 2
    var billTotal : Float = 0.0
    var individualTotal : Float = 0.0
    
    mutating func setIndividualTotal() {
        individualTotal = billTotal * (1 + tipPercentage) / Float(numberOfPeople)
    }
}
