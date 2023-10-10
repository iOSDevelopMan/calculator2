//
//  FirebaseService.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import Analytics

class FirebaseService {
    init() {
        configure()
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
}

// MARK: - AnalyticsServiceProtocol
extension FirebaseService: AnalyticsProtocol {
    func trackEvent(_ event: AnalyticsEventProtocol) {
        Analytics.logEvent(event.name, parameters: event.params)
    }
}
