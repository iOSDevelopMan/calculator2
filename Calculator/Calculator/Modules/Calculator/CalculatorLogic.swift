//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Alexey Kachura on 18.09.23.
//

import Foundation

struct CalculatorLogic {
    // MARK: - Types
    enum Operation {
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equal
        case clear
        
        init?(string: String) {
            switch string {
            case "cos": self = .unary({ cos($0.radiansValue) })
            case "sin": self = .unary({ sin($0.radiansValue) })
            case "+": self = .binary( + )
            case "-": self = .binary( - )
            case "*": self = .binary( * )
            case "/": self = .binary( / )
            case "=": self = .equal
            case "AC": self = .clear
            default: return nil
            }
        }
    }
    
    struct BinaryOperationInfo {
        let firstOperand: Double
        let binaryFunction: (Double, Double) -> Double
        
        func evaluate(with secondOperand: Double) -> Double {
            binaryFunction(firstOperand, secondOperand)
        }
    }
    
    // MARK: - Properties
    private(set) var result: Double = 0
    
    private var binaryOperationInfo: BinaryOperationInfo?
    
    // MARK: - Main
    mutating func setOperand(_ operand: Double) {
        result = operand
    }
    
    mutating func performOperation(_ symbol: String) {
        guard let operation = Operation(string: symbol) else { return }
        
        switch operation {
        case .unary(let function): result = function(result)
        case .binary(let function): binaryOperationInfo = .init(firstOperand: result, binaryFunction: function)
        case .equal:
            if let binaryOperationInfo {
                result = binaryOperationInfo.evaluate(with: result)
            }
        case .clear:
            binaryOperationInfo = nil
            result = 0
        }
    }
}
