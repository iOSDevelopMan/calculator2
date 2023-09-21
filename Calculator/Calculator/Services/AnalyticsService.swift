//
//  AnalyticsService.swift
//  Calculator
//
//  Created by Alexey Kachura on 26.09.23.
//

import Foundation

protocol AnalyticsServiceProtocol {
    func trackEvent(_ eventName: String, params: [String: Any]?)
}

class AnalyticsService: AnalyticsServiceProtocol {
    private let services: [AnalyticsServiceProtocol]
    
    init(services: [AnalyticsServiceProtocol] = [FirebaseService.shared]) {
        self.services = services
    }
    
    func trackEvent(_ eventName: String, params: [String: Any]?) {
        services.forEach { $0.trackEvent(eventName, params: params) }
    }
}
