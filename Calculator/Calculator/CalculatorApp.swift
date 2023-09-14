//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Alexey Kachura on 14.09.23.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView(viewModel: CalculatorViewModel())
        }
    }
}
