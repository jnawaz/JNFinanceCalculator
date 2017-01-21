//
//  JNLoanCalculator.swift
//  JNFinanceCalculator
//
//  Created by Jamil Nawaz on 21/01/2017.
//  Copyright (c) 2017 Jamil Nawaz. All rights reserved.
//

import Foundation

public class JNLoanCalculator {

    var loanAmount: Double = 0.0
    var apr: Double = 0.0
    var loanTerm: Int = 0 // in Months

    var monthlyRepayment: Double?
    var totalInterest: Double?
    var totalRepayment: Double?


    func calculate() {
        assert(Double(loanAmount) > 0.0, "Loan amount has to be greater than 0.00")
        assert(Int(loanTerm) > 0, "Loan term has to be greater than 0 months")


    }
}
