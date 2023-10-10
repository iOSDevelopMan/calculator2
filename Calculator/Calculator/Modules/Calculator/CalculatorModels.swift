//
//  CalculatorModels.swift
//  Calculator
//
//  Created by Alexey Kachura on 10.10.23.
//

import Foundation
import Analytics

enum CalculatorModels {
    struct Event: AnalyticsEventProtocol {
        var name: String
        var params: [String : Any]?
        
        static func buttonPressed(title: String) -> AnalyticsEventProtocol {
            Event(name: "button_pressed", params: ["title": title])
        }
        
        static func error(service: String, description: String) -> AnalyticsEventProtocol {
            Event(name: "error", params: ["service": service, "description": description])
        }
    }
}
