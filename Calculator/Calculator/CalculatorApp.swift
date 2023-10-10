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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private var isFirstColorScheme = false
    
    var body: some Scene {
        WindowGroup {
            let colorScheme: ColorSchemeProtocol = isFirstColorScheme ? FirstColorScheme() : SecondColorScheme()
            let firebaseService = FirebaseService()
            let analyticsCenter = AnalyticsCenter(services: [firebaseService])
            
            CalculatorView(
                viewModel: CalculatorViewModel(
                    analyticsService: analyticsCenter,
                    colorSchemeManager: ColorSchemeManager(colorScheme)
                )
            )
        }
    }
}
