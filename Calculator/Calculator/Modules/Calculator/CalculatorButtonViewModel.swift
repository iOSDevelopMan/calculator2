//
//  CalculatorButtonViewModel.swift
//  Calculator
//
//  Created by Alexey Kachura on 15.09.23.
//

import SwiftUI

struct CalculatorButtonViewModel: Identifiable, Hashable {
    enum ActionType {
        case operand
        case operation
        case exchange
    }
    
    let title: String
    let foregroundColor: Color
    let backgroundColor: Color
    let actionType: ActionType
    let isEnabled: Bool
    
    var id: String { title }
}
