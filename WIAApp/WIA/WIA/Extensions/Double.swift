//
//  Double.swift
//  WIA
//
//  Created by Юлия Бегман on 26.07.2023.
//

import Foundation

extension Double {
    func rounded(_ value: Int) -> Double {
        let divisor = pow(10.0, Double(value))
        return (self * divisor).rounded() / divisor
    }
    
    func roundedS(_ value: Int) -> String {
        return String(format: "%.\(value)f", rounded(value))
    }
}
