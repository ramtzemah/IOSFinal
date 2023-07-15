//
//  NSNumberExtension.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import UIKit

extension NSNumber {
    func toCurrency(min: Int = 0, max: Int = 2) -> String {
        let decimalValue = NSDecimalNumber(value: Double(self))
        let formatter = NumberFormatter()
        formatter.roundingMode = .down
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = min
        formatter.maximumFractionDigits = max
        return formatter.string(from: self) ?? "-"
    }

    func toDecimal(min: Int = 0, max: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.roundingMode = .down
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = min
        formatter.maximumFractionDigits = max
        return formatter.string(from: self) ?? "-"
    }
}
