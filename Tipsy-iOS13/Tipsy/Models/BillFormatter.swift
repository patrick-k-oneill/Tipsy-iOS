//
//  BillFormatter.swift
//  Tipsy
//
//  Created by Patrick O'Neill on 11/10/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

extension String {
    
    // Formats billTextField for currency input
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    // Removes '$' prefix from bill text string
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

// Contains methods for formatting billTextField and retreiving billTotal as a float
struct BillFormatter    {
    
    func formatTextField(text: String?) -> String?   {
        let textWithPrefix = text?.currencyInputFormatting()
        return textWithPrefix
    }
    
    func getBillTotal(text: String) -> Float?    {
        
        // Remove '$' prefix
        let amountWithoutPrefix = text.deletingPrefix("$")
        
        // Return billTotal as a float
        let formatter = NumberFormatter()
        return formatter.number(from: amountWithoutPrefix)?.floatValue
    }
}
