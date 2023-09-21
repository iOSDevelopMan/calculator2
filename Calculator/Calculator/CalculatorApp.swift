//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Alexey Kachura on 14.09.23.
//

import SwiftUI

@main
struct CalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CalculatorView(viewModel: CalculatorViewModel())
        }
    }
}
