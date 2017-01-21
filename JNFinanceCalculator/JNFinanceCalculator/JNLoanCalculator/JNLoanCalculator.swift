//
//  JNLoanCalculator.swift
//  JNFinanceCalculator
//
//  Created by Jamil Nawaz on 21/01/2017.
//  Copyright (c) 2017 Jamil Nawaz. All rights reserved.
//

import Foundation

@objc
public class JNLoanCalculator: NSObject {

    var loanAmount: Double = 0.0
    var apr: Double = 0.0
    var loanTerm: Int = 0 // in months

    var monthlyRepayment: Double?
    var totalInterest: Double?
    var totalRepayment: Double?


    func calculate() {
        assert(Double(loanAmount) > 0.0, "Loan amount has to be greater than 0.00")
        assert(Int(loanTerm) > 0, "Loan term has to be greater than 0 months")

        var dcmMonthlyRepayment, dcmTotalInterest, dcmTotalRepayment: NSDecimalNumber

        let monthlyRate: Double = workoutMonthlyRate(interest: apr)

        let monthlyPayment: Double = workoutMonthlyRepayment(
                loanAmount: self.loanAmount,
                monthlyRate: monthlyRate,
                numMonths: loanTerm
        )

        let totalInterest: Double = workoutTotalInterest(
                loanAmount: loanAmount,
                numMonths: loanTerm,
                monthlyPayment: monthlyPayment,
                monthlyRate: monthlyRate
        )

        dcmMonthlyRepayment = NSDecimalNumber(string: String(format: "%.2f", arguments: [monthlyPayment]))
        dcmTotalInterest = NSDecimalNumber(string: String(format: "%.2f", arguments: [totalInterest]))
        dcmTotalRepayment = NSDecimalNumber(string: String(format: "%.2f", arguments: [(loanAmount + totalInterest)]))

        self.monthlyRepayment = round(dcmMonthlyRepayment.doubleValue * 100) / 100
        self.totalInterest = round(dcmTotalInterest.doubleValue * 100) / 100
        self.totalRepayment = round(dcmTotalRepayment.doubleValue * 100) / 100

    }

    func workoutMonthlyRate(interest: Double) -> Double {
        let firstComponent = 1.0 + (interest / 100.00)
        let secondComponent = 1.0 / 12.0

        let powers = pow(firstComponent, secondComponent)

        return (powers - 1) * 100
    }

    func workoutMonthlyRepayment(loanAmount: Double, monthlyRate: Double, numMonths: Int) -> Double {
        let firstComponent = (loanAmount * monthlyRate) / 100.00

        let secondPartA = (1.0 + (monthlyRate / 100))
        let secondPartB = 0.0 - Double(numMonths)

        let secondPartPower = 1.0 - pow(secondPartA, secondPartB)

        return firstComponent / secondPartPower
    }

    func workoutTotalInterest(loanAmount: Double, numMonths: Int, monthlyPayment: Double, monthlyRate: Double) -> Double {

        var ipmt: Double = 0.0

        var interestAccrued: Double = 0.0
        var updatedLoanAmount: Double = loanAmount

        var interestRate: Double = monthlyRate / 100.00

        var firstBracket, secondBracket, thirdBracket: Double

        for index in 1...numMonths {
            firstBracket = (1.00 + interestRate)
            secondBracket = (-1.00 + 1)
            thirdBracket = (monthlyPayment + (interestRate * updatedLoanAmount))

            var firstAndSecond: Double = pow(firstBracket, secondBracket)
            var firstAndSecondMultiplied = firstAndSecond * thirdBracket

            ipmt = fabs(((monthlyPayment - firstAndSecondMultiplied) * 100) / 100.00)

            interestAccrued = interestAccrued + ipmt

            updatedLoanAmount = updatedLoanAmount - (monthlyPayment - fabs(monthlyPayment - firstAndSecondMultiplied))
        }

        return interestAccrued
    }
}
