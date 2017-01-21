//
//  JNFinanceCalculatorTests.swift
//  JNFinanceCalculatorTests
//
//  Created by Jamil Nawaz on 21/01/2017.
//  Copyright (c) 2017 Jamil Nawaz. All rights reserved.
//

import XCTest
@testable import JNFinanceCalculator

class JNFinanceCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoanCalculator() {
        let calculator: JNLoanCalculator = JNLoanCalculator()
        calculator.loanAmount = 1764.19
        calculator.apr = 9.9
        calculator.loanTerm = 24

        calculator.calculate()

        XCTAssert(calculator.totalInterest == 179.41)
        XCTAssert(calculator.monthlyRepayment == 80.98)
        XCTAssert(calculator.totalRepayment == 1943.60)

    }
    
}
