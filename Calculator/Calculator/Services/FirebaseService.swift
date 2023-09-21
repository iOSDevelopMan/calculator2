//
//  FirebaseService.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics

protocol FirebaseServiceProtocol {
    func configure()
}

class FirebaseService {
    static let shared = FirebaseService()
    private init() {}
}

// MARK: - FirebaseServiceProtocol
extension FirebaseService: FirebaseServiceProtocol {
    func configure() {
        FirebaseApp.configure()
    }
}

// MARK: - AnalyticsServiceProtocol
extension FirebaseService: AnalyticsServiceProtocol {
    func trackEvent(_ eventName: String, params parameters: [String : Any]?) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
}
