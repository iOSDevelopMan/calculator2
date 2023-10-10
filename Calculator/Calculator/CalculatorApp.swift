//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Alexey Kachura on 14.09.23.
//

import SwiftUI
import Analytics

@main
struct CalculatorApp: App {
    private var isFirstColorScheme = false
    
    var body: some Scene {
        WindowGroup {
            CalculatorView(viewModel: CalculatorViewModel())
        }
    }
    
    init() {
        setupDependencies()
    }
    
    private func setupDependencies() {
        @Provider var currencyConvertorService = CurrencyConvertorService() as CurrencyConvertorServiceProtocol
        @Provider var reachabilityService = ReachabilityService.shared as ReachabilityServiceProtocol
        
        let colorScheme = (isFirstColorScheme ? FirstColorScheme() : SecondColorScheme()) as ColorSchemeProtocol
        @Provider var colorSchemeManager = ColorSchemeManager(colorScheme) as ColorSchemeManagerProtocol
        
        let firebaseService = FirebaseService()
        @Provider var analyticsCenter = AnalyticsCenter(services: [firebaseService]) as AnalyticsProtocol
    }
}
