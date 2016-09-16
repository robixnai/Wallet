//
//  Entry.swift
//  Wallet
//
//  Created by Guilherme Silva on 9/16/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import Foundation

class Entry {
    var months: Int
    var value: Double
    var creationDate: Date
    
    var remainingMonths: Int {
        get {
            //            let months = Calendar.current.dateComponents([.month], from: creationDate).month ?? 0
            let calendar = NSCalendar.current
            
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: creationDate)
            
            let components = calendar.dateComponents([.month], from: date1, to: date2)
            
            return validateRemainingMonth(remainingMonths: components.month ?? 0)
        }
    }
    
    var remainingValue: Double {
        get {
            return validateRemainingValue(remainingValue: value - paidValue)
        }
    }
    
    var paidValue: Double {
        get {
            return value / Double(months) * Double(months - remainingMonths)
        }
    }
    
    var valueByMonth: Double {
        get {
            return value / Double(months)
        }
    }
    
    var isFullyPaid: Bool {
        get {
            return remainingMonths <= 0
        }
    }
    
    init?(totalValue value:Double, numberOfmonths months:Int, creationDate date:Date) {
        self.value = value
        self.months = months
        
        if (date <= Date()) {
            self.creationDate = date
        } else {
            return nil
        }
    }
    
    convenience init?(totalValue value:Double, numberOfmonths months:Int) {
        self.init(totalValue: value, numberOfmonths: months, creationDate: Date())
    }
    
    func validateRemainingMonth(remainingMonths months:Int) -> Int{
        return (months < 0 || months > self.months) ? 0 : months
    }
    
    func validateRemainingValue(remainingValue value:Double) -> Double{
        return (value < 0 || value > self.value) ? 0 : value
    }
    
    func getInstallmentString() -> String {
        let stringRemaining = getMoneyString(money: remainingValue)
        let stringValue = getMoneyString(money: value)
        return "\(remainingMonths)/\(months) - R$\(stringRemaining)/R$\(stringValue)"
    }
    
    
    private
    func getMoneyString(money: Double) -> String{
        return NSString(format: "%.2f", money) as String
    }
}
