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
    
    private var isFirstColorScheme = false
    
    var body: some Scene {
        WindowGroup {
            let colorScheme: ColorSchemeProtocol = isFirstColorScheme ? FirstColorScheme() : SecondColorScheme()
            
            CalculatorView(viewModel: CalculatorViewModel(colorSchemeManager: ColorSchemeManager(colorScheme)))
        }
    }
}
