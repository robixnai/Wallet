//
//  WalletTests.swift
//  WalletTests
//
//  Created by Guilherme Silva on 9/16/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import XCTest
@testable import Wallet

class WalletTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // TEST A VALID DATE / MONTH AND VALUE
    func testValidEntry() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2016/08/16")!
        
        if let entry = Entry(totalValue: 869, numberOfmonths: 10, creationDate: someDateTime) {
            XCTAssert(entry.value == entry.paidValue + entry.remainingValue)
            XCTAssert(entry.value == entry.valueByMonth * Double(entry.months))
            XCTAssert(entry.months == entry.remainingMonths + Int(entry.paidValue / entry.value * 10))
        }
    }
    
    // TEST A INVALID DATE
    func testInvalidDateEntry() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2016/12/16")!
        XCTAssertNil(Entry(totalValue: 869, numberOfmonths: 10, creationDate: someDateTime))
    }
    
    // TEST OLD DATE
    func testOldDateEntry() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2015/08/16")!
        
        if let entry = Entry(totalValue: 869, numberOfmonths: 10, creationDate: someDateTime) {
            XCTAssert(entry.isFullyPaid)
            XCTAssert(entry.remainingValue == 0)
            XCTAssert(entry.remainingMonths == 0)
            XCTAssert(entry.paidValue == entry.value)
        }
    }
    
}
